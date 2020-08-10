import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

abstract class CryptoUtil {
  static const String PRIVATE_KEY_ID = 'PRIVATE_KEY_ID';
  static const String PUBLIC_KEY_ID = 'PUBLIC_KEY_ID';

  // Create storage
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  AsymmetricKeyPair generateKeyPair();
  String signChallenge(PrivateKey p, Uint8List msg);
  String encodePublicKey(PublicKey p);
  PublicKey decodePublicKey(String pemString);
  String encodePrivateKey(PrivateKey p);
  PrivateKey decodePrivateKey(String pemString);

  // Protected
  @protected
  void storePublicKey(PublicKey p) {
    String encoded = encodePublicKey(p);
    storage.write(key: PUBLIC_KEY_ID, value: encoded);
  }

  @protected
  void storePrivateKey(PrivateKey p) {
    String encoded = encodePrivateKey(p);
    storage.write(key: PRIVATE_KEY_ID, value: encoded);
  }

  @protected
  Future<PrivateKey> retrievePrivateKey() async {
    String pemString = await storage.read(key: PRIVATE_KEY_ID);
    return decodePrivateKey(pemString);
  }

  @protected
  SecureRandom getSecureRandom() {
    FortunaRandom secureRandom = FortunaRandom();
    Random random = Random.secure();
    final List<int> seeds = [];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  // Public interface
  void generateAndStoreKeyPair() {
    AsymmetricKeyPair pair = generateKeyPair();
    storePublicKey(pair.publicKey);
    storePrivateKey(pair.privateKey);
  }

  Future<PublicKey> retrievePublicKey() async {
    String pemString = await storage.read(key: PUBLIC_KEY_ID);
    return decodePublicKey(pemString);
  }
}