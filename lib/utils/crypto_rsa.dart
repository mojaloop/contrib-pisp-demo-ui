import 'dart:convert';
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'crypto.dart';

class CryptoRSAUtil extends CryptoUtil {
  @override
  AsymmetricKeyPair generateKeyPair() => CryptoUtils.generateRSAKeyPair();

  // Needs to give signature (base-64) AND a public key string (PEM base64)
  @override
  String signChallenge(covariant RSAPrivateKey p, Uint8List msg) => base64.encode(CryptoUtils.rsaSign(p, msg));

  @override
  RSAPrivateKey decodePrivateKey(String pemString) => CryptoUtils.rsaPrivateKeyFromPem(pemString);

  @override
  RSAPublicKey decodePublicKey(String pemString) => CryptoUtils.rsaPublicKeyFromPem(pemString);

  @override
  String encodePrivateKey(covariant RSAPrivateKey privateKey) => CryptoUtils.encodeRSAPrivateKeyToPem(privateKey);

  @override
  String encodePublicKey(covariant RSAPublicKey publicKey) => CryptoUtils.encodeRSAPublicKeyToPem(publicKey);

  @override
  Future<String> signChallengeWithStoredPrivateKey(Uint8List challenge) async {
    final RSAPrivateKey pk = await retrievePrivateKey() as RSAPrivateKey;
    return signChallenge(pk, challenge);
  }
}