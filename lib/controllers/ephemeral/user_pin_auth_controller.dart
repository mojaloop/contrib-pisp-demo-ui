import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PINAuthController extends GetxController {

  // Constructor to fetch PIN automatically
  PINAuthController() {
    _fetchPIN();
  }

  // Constants
  static const String key = 'USER_PIN';
  static const Duration timeoutDuration = Duration(seconds: 3);
  static const String _timeout = 'timeout';

  // Fields to be populated
  String _correctPIN = '';
  bool _userSetPIN = false;

  // Access native data store
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Returns whether or not the user set a PIN
  bool get userSetPIN => _userSetPIN;

  // Synchronous
  // Called after correct PIN has been populated
  bool authenticate(String pin) {
    // TODO: Implement actual authentication logic
    _correctPIN = '123456';
    if(pin == _correctPIN) {
      return true;
    }
    return false;
  }

  Future<void> _fetchPIN() async {
    final String pin = await Future.any([
      storage.read(key: PINAuthController.key),
      Future.delayed(PINAuthController.timeoutDuration, () => _timeout)]);

    if(pin == _timeout) {
      _userSetPIN = false;
    }
    else {
      _correctPIN = pin;
      _userSetPIN = true;
    }
  }

  Future<void> storeNewPIN(String pin) async {
    _correctPIN = pin;
    await storage.write(key: PINAuthController.key, value: pin);
  }
}
