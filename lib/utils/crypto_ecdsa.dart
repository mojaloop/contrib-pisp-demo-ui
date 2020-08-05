import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

class CryptoECDSAUtil {

  PublicKey _pubKey;
  PrivateKey _privateKey;

  void generateKeyPair() {
    // Set EC to secp256k1
    ECDomainParameters params = ECDomainParameters('secp256k1');
    ECKeyGenerator keyGen = ECKeyGenerator();
    keyGen.init(ECKeyGeneratorParameters(params));
    keyGen.generateKeyPair();

    AsymmetricKeyPair keys = keyGen.generateKeyPair();

    // TODO: DO NOT STORE THEM LIKE THIS
    _pubKey = keys.publicKey;
    _privateKey = keys.privateKey;
  }

  String signChallenge(Uint8List msg) {
    ECDSASigner signer = ECDSASigner(SHA256Digest(), null);
    signer.init(true, PrivateKeyParameter(_privateKey));
    ECSignature sig = signer.generateSignature(msg) as ECSignature;
    
  }
}