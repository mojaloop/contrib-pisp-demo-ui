import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:asn1lib/asn1lib.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

abstract class CryptoUtil {
  static const String PRIVATE_KEY_ID = 'PRIVATE_KEY_ID';
  static const String PUBLIC_KEY_ID = 'PUBLIC_KEY_ID';

  // Create storage
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Protected
  @protected
  PrivateKey decodePrivateKey(String pemString);

  @protected
  AsymmetricKeyPair generateKeyPair();

  @protected
  String signChallenge(PrivateKey p, Uint8List challenge);

  @protected
  String encodePublicKey(PublicKey p);

  @protected
  PublicKey decodePublicKey(String pemString);

  @protected
  String encodePrivateKey(PrivateKey p);

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
    final String pemString = await storage.read(key: PUBLIC_KEY_ID);
    return decodePublicKey(pemString);
  }

  Future<String> retrievePublicKeyInPEM() async {
    final String pemString = await storage.read(key: PUBLIC_KEY_ID);
    return pemString;
  }

  @protected
  ASN1ObjectIdentifier convertOIDFromStringToASN1(String path) =>
      _fromComponents(path.split('.').map((v) => int.parse(v)).toList());

  // For more info: https://docs.microsoft.com/en-us/windows/win32/seccertenroll/about-object-identifier?redirectedfrom=MSDN
  ASN1ObjectIdentifier _fromComponents(List<int> components) {
    assert(components.length >= 2);
    assert(components[0] < 3);
    assert(components[1] < 64);

    var oi = <int>[];
    oi.add(components[0] * 40 + components[1]);

    for (var ci = 2; ci < components.length; ci++) {
      final position = oi.length;
      var v = components[ci];

      var first = true;
      do {
        var remainder = v & 127;
        v = v >> 7;
        if (first) {
          first = false;
        } else {
          remainder |= 0x80;
        }

        oi.insert(position, remainder);
      } while (v > 0);
    }

    return ASN1ObjectIdentifier(oi, tag: 0x06);
  }

  Future<String> signChallengeWithStoredPrivateKey(Uint8List challenge);
}