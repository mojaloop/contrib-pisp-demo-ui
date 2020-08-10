import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:pispapp/utils/crypto.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/src/utils.dart';
import 'package:pointycastle/ecc/ecc_fp.dart' as ecc_fp;

/// Uses secp256k1 curve
class CryptoECDSAUtil extends CryptoUtil {
  // src: http://oid-info.com/get/1.3.132.0.10
  static const String secp256k1Name = 'secp256k1';
  static const String secp256k1ObjectIdentifier = '1.3.132.0.10';

  // Used for PEM
  static const String BEGIN_EC_PUBLIC_KEY = '-----BEGIN EC PUBLIC KEY-----';
  static const String END_EC_PUBLIC_KEY = '-----END EC PUBLIC KEY-----';
  static const String BEGIN_EC_PRIVATE_KEY = '-----BEGIN EC PRIVATE KEY-----';
  static const String END_EC_PRIVATE_KEY = '-----END EC PRIVATE KEY-----';
  
  @override
  AsymmetricKeyPair generateKeyPair() => CryptoUtils.generateEcKeyPair(curve: secp256k1Name);

  /// ECDSASignature ::= SEQUENCE {
///    r   INTEGER,
///    s   INTEGER
/// }
  String _convertECSigToString(ECSignature sig) {
    final ASN1Sequence seq = ASN1Sequence();
    seq.add(ASN1Integer(sig.r));
    seq.add(ASN1Integer(sig.s));
    return base64.encode(seq.encodedBytes);
  }

  @override
  String signChallenge(covariant ECPrivateKey p, Uint8List msg) {
    final ECDSASigner signer = ECDSASigner(SHA256Digest(), null);
    signer.init(true, PrivateKeyParameter(p));
    final ECSignature sig = signer.generateSignature(msg) as ECSignature;
    return _convertECSigToString(sig);
  }

  @override
  ECPrivateKey decodePrivateKey(String pemString) {
    var bytes = CryptoUtils.getBytesFromPEMString(pemString);
    var asn1Parser = ASN1Parser(bytes);
    var topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
    var privateKeyAsOctetString =
    topLevelSeq.elements.elementAt(1) as ASN1OctetString;
    var x = privateKeyAsOctetString.contentBytes();

    return ECPrivateKey(decodeBigInt(x), ECDomainParameters(secp256k1Name));
  }

  @override
  String encodePrivateKey(covariant ECPrivateKey ecPrivateKey) {
    ASN1ObjectIdentifier.registerFrequentNames();
    var outer = ASN1Sequence();

    var version = ASN1Integer(BigInt.from(1));
    var privateKeyAsBytes = encodeBigInt(ecPrivateKey.d);
    var privateKey = ASN1OctetString(privateKeyAsBytes);
    var choice = ASN1Sequence(tag: 0xA0);

    choice
        .add(ASN1ObjectIdentifier.fromComponentString(secp256k1ObjectIdentifier));

    var publicKey = ASN1Sequence(tag: 0xA1);

    var subjectPublicKey =
    ASN1BitString(ecPrivateKey.parameters.G.getEncoded(false));
    publicKey.add(subjectPublicKey);

    outer.add(version);
    outer.add(privateKey);
    outer.add(choice);
    outer.add(publicKey);
    var dataBase64 = base64.encode(outer.encodedBytes);
    var chunks = StringUtils.chunk(dataBase64, 64);

    return '$BEGIN_EC_PRIVATE_KEY\n${chunks.join('\n')}\n$END_EC_PRIVATE_KEY';
  }

  @override
  ECPublicKey decodePublicKey(String pemString) {
    var bytes = CryptoUtils.getBytesFromPEMString(pemString);
    var asn1Parser = ASN1Parser(bytes);
    var topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

    var subjectPublicKey = topLevelSeq.elements[1];
    var compressed = false;
    var pubBytes = subjectPublicKey.contentBytes();
    // Looks good so far!
    var firstByte = pubBytes.elementAt(0);
    if (firstByte != 4) {
      compressed = true;
    }
    var x = pubBytes.sublist(1, (pubBytes.length / 2).round());
    var y = pubBytes.sublist(1 + x.length, pubBytes.length);
    var params = ECDomainParameters(secp256k1Name);
    var decodedX = decodeBigInt(x);
    var decodedY = decodeBigInt(y);
    var curveFromX = params.curve.fromBigInteger(decodedX) as ecc_fp.ECFieldElement;
    var curveFromY = params.curve.fromBigInteger(decodedY) as ecc_fp.ECFieldElement;
    var curve = params.curve as ecc_fp.ECCurve;
    var ecpoint = ecc_fp.ECPoint(curve, curveFromX, curveFromY, compressed);
    return ECPublicKey(ecpoint, params);
  }

  @override
  String encodePublicKey(covariant ECPublicKey p) {
    ASN1ObjectIdentifier.registerFrequentNames();
    var outer = ASN1Sequence();
    var algorithm = ASN1Sequence();
    algorithm.add(ASN1ObjectIdentifier.fromName('ecPublicKey'));
    algorithm.add(ASN1ObjectIdentifier.fromComponentString(secp256k1ObjectIdentifier));
    var subjectPublicKey = ASN1BitString(p.Q.getEncoded(false));

    outer.add(algorithm);
    outer.add(subjectPublicKey);
    var dataBase64 = base64.encode(outer.encodedBytes);
    var chunks = StringUtils.chunk(dataBase64, 64);

    return '$BEGIN_EC_PUBLIC_KEY\n${chunks.join('\n')}\n$END_EC_PUBLIC_KEY';
  }

  @override
  Future<String> signChallengeWithStoredPrivateKey(Uint8List challenge) async {
    final ECPrivateKey pk = await retrievePrivateKey() as ECPrivateKey;
    return signChallenge(pk, challenge);
  }
}