import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pispapp/controllers/ephemeral/local_auth_controller.dart';
import 'package:pispapp/routes/app_pages.dart';

class PINEntryController extends GetxController {
  // Constructor to fetch PIN automatically
  PINEntryController() {
    _fetchPIN();
  }

  // Constants
  static const String key = 'USER_PIN';
  static const Duration timeoutDuration = Duration(milliseconds: 1000);
  static const int PINlength = 6;

  // Storage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Fields to be populated
  String _correctPIN = '';
  bool _userSetPIN = false;

  // Returns whether or not the user set a PIN
  bool get userSetPIN => _userSetPIN;

  void onFallbackVerificationNeeded() {
    Get.toNamed<dynamic>(Routes.PIN_ENTRY);
  }

  // Called after correct PIN has been populated
  bool authenticate(String pin) => pin == _correctPIN;

  // Authentication process
  void onPINEntered(String pin, TextEditingController tc, StreamController<ErrorAnimationType> ec) {
    if(!_userSetPIN) { return; } // Do nothing if there is no previous set PIN
    tc.clear();
    if (authenticate(pin)) {
      // PIN entry screen always opened on top of something AND
      // is not poppable via device controls so we can be sure it
      // is still on top when we call this
      Get.back();
      Get.find<LocalAuthController>().verificationInProgress = false;
    }
    else {
      // Shakes the entry fields to indicate incorrect PIN
      ec.add(ErrorAnimationType.shake);
    }
  }

  Future<void> _fetchPIN() async {
    final String pin = await Future.any([
      _storage.read(key: PINEntryController.key),
      Future.delayed(PINEntryController.timeoutDuration, () => null)
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
    update();
  }

  Future<void> storeNewPIN(String pin) async {
    print('storing new pin $pin');
    await Future.any([
      _storage.write(key: PINEntryController.key, value: pin),
      Future.delayed(PINEntryController.timeoutDuration, () => null)
    ]);

    // Update new PIN
    await _fetchPIN();
  }
}
