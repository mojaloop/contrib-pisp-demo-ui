import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:asn1lib/asn1lib.dart';

class CryptoUtil {
  static const String SHA256_DIGEST_IDENTIFIER_HEX = '0609608648016503040201';

  PublicKey _pubKey;
  PrivateKey _privateKey;

  void generateKeyPair() {
    RSAKeyGenerator keyGen = RSAKeyGenerator();
    BigInt publicExp = BigInt.from(65537);
    int bitStrength = 2048;
    int certainty = 12;
    keyGen.init(RSAKeyGeneratorParameters(publicExp, bitStrength, certainty));
    AsymmetricKeyPair keys = keyGen.generateKeyPair();

    // TODO: DO NOT STORE THEM LIKE THIS
    _pubKey = keys.publicKey;
    _privateKey = keys.privateKey;
  }

  // Needs to give signature (base-64) AND a public key string (PEM base64)
  String signChallenge(Uint8List msg) {
    RSASigner signer = RSASigner(SHA256Digest(), SHA256_DIGEST_IDENTIFIER_HEX);
    signer.init(true, PrivateKeyParameter(_privateKey));
    RSASignature sig = signer.generateSignature(msg);
    return base64.encode(sig.bytes);
  }

  // Convenience function to encode public key to PEM PKCS1
  // src: https://github.com/Vanethos/flutter_rsa_generator_example/blob/master/lib/utils/rsa_key_helper.dart
  String encodePrivateKeyToPemPKCS1(RSAPrivateKey privateKey) {

    var topLevel = new ASN1Sequence();

    var version = ASN1Integer(BigInt.from(0));
    var modulus = ASN1Integer(privateKey.n);
    var publicExponent = ASN1Integer(privateKey.exponent);
    var privateExponent = ASN1Integer(privateKey.d);
    var p = ASN1Integer(privateKey.p);
    var q = ASN1Integer(privateKey.q);
    var dP = privateKey.d % (privateKey.p - BigInt.from(1));
    var exp1 = ASN1Integer(dP);
    var dQ = privateKey.d % (privateKey.q - BigInt.from(1));
    var exp2 = ASN1Integer(dQ);
    var iQ = privateKey.q.modInverse(privateKey.p);
    var co = ASN1Integer(iQ);

    topLevel.add(version);
    topLevel.add(modulus);
    topLevel.add(publicExponent);
    topLevel.add(privateExponent);
    topLevel.add(p);
    topLevel.add(q);
    topLevel.add(exp1);
    topLevel.add(exp2);
    topLevel.add(co);

    var dataBase64 = base64.encode(topLevel.encodedBytes);

    return '-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----';
  }

  String encodePublicKeyToPemPKCS1(RSAPublicKey publicKey) {
    var topLevel = new ASN1Sequence();

    topLevel.add(ASN1Integer(publicKey.modulus));
    topLevel.add(ASN1Integer(publicKey.exponent));

    var dataBase64 = base64.encode(topLevel.encodedBytes);
    return '-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----';
  }
}
}