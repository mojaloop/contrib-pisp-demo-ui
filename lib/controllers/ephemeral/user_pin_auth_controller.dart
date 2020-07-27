import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PINAuthController {
  static const String key = 'USER_PIN';
  static const Duration timeoutDuration = Duration(seconds: 3);
  static const String _errorKey = 'error';
  // Create storage
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> didPreviouslySetPIN() async {
    print('in func');
    final String pin = await Future.any([storage.read(key: PINAuthController.key), Future.delayed(PINAuthController.timeoutDuration,
            () => _errorKey)]);

    if(pin == _errorKey) {
      return false;
    }

    return true;
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
