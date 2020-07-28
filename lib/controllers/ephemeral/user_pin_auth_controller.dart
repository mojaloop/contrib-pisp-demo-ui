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
  static const Duration timeoutDuration = Duration(milliseconds: 1000);

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Fields to be populated
  String _correctPIN = '';
  bool _userSetPIN = false;

  // Returns whether or not the user set a PIN
  bool get userSetPIN => _userSetPIN;

  // Synchronous
  // Called after correct PIN has been populated
  bool authenticate(String pin) => pin == _correctPIN;

  Future<void> _fetchPIN() async {
    final String pin = await Future.any([
      _storage.read(key: PINAuthController.key),
      Future.delayed(PINAuthController.timeoutDuration, () => null)
    ]);

    if (pin == null) {
      print('no previous PIN set');
      _userSetPIN = false;
    }
    else {
      print('fetched pin as $pin');
      _userSetPIN = true;
      _correctPIN = pin;
    }
  }

  Future<void> storeNewPIN(String pin) async {
    print('storing new pin $pin');
    await Future.any([
      _storage.write(key: PINAuthController.key, value: pin),
      Future.delayed(PINAuthController.timeoutDuration, () => null)
    ]);

    // Update new PIN
    await _fetchPIN();
  }
}
