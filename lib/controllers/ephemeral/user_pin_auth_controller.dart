import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pispapp/routes/app_pages.dart';

class PINAuthController extends GetxController {
  // Constructor to fetch PIN automatically
  PINAuthController() {
    _fetchPIN();
  }

  // Constants
  static const String key = 'USER_PIN';
  static const Duration timeoutDuration = Duration(milliseconds: 1000);

  // Storage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Handles animation for error
  StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();

  // Handles text field
  TextEditingController textEditingController = TextEditingController();

  // Fields to be populated
  String _correctPIN = '';
  bool _userSetPIN = false;

  // Returns whether or not the user set a PIN
  bool get userSetPIN => _userSetPIN;

  // Called after correct PIN has been populated
  bool authenticate(String pin) => pin == _correctPIN;

  // Authentication process
  void onPINEntered(String pin) {
    textEditingController.clear();
    if (authenticate(pin)) {
      // PIN entry screen always opened on top of something AND
      // is not poppable via device controls so we can be sure it
      // is still on top when we call this
      Get.back();
    }
    else {
      // Shakes the entry fields to indicate incorrect PIN
      errorController.add(ErrorAnimationType.shake);
    }
  }

  Future<void> onUserVerificationNeeded() async {
    var localAuth = LocalAuthentication();
    try {
      bool didAuth = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Please verify your identity',
          useErrorDialogs: false);

      // Use PIN screen if biometric did not validate
      if(!didAuth) {
        Get.toNamed<dynamic>(Routes.PIN_ENTRY);
      }
    } catch(e) {
      Get.toNamed<dynamic>(Routes.PIN_ENTRY);
    }
  }

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
