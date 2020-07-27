import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class PINAuthController {
// Create storage
final storage = const FlutterSecureStorage();

  Future<bool> didPreviouslySetPIN() async {
    // TODO:
    final pin = await storage.read(key: 'user_pin');
    print(pin);
    return false;
  }

  bool authenticate(String pin) {
    // TODO:
    try {
      int parsed = int.parse(pin);
      return false;
    } catch (e) {
      return false;
    }
  }

  void storeNewPIN(int pin) {

  }
}
