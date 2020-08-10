import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pispapp/controllers/ephemeral/local_auth_controller.dart';
import 'package:pispapp/routes/app_routes.dart';
import 'package:pispapp/utils/log_printer.dart';
import 'package:pispapp/utils/secure_storage.dart';

class PINEntryController extends GetxController {
  // Constructor to fetch PIN automatically
  PINEntryController() {
    _fetchPIN();
  }

  // Use storage class
  SecureStorage _storage = SecureStorage();

  static const Duration timeoutDuration = Duration(milliseconds: 1000);
  static const int PINlength = 6;
  static final logger = getLogger('PinEntryController');

  // Fields to be populated
  String _correctPIN = '';
  bool _userSetPIN = false;

  // Returns whether or not the user set a PIN
  bool get userSetPIN => _userSetPIN;

  void onFallbackVerificationNeeded() {
    Get.toNamed<dynamic>(Routes.PIN_ENTRY);
  }

  // Called after correct PIN has been populated
  bool _isCorrectPin(String pin) => pin == _correctPIN;

  // Authentication process
  void onPINEntered(String pin, TextEditingController tc, StreamController<ErrorAnimationType> ec) {
    tc.clear();
    if (_isCorrectPin(pin)) {
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
    final String pin = await _storage.readUserPIN();

    if (pin == null) {
      logger.i('no previous PIN set');
      _userSetPIN = false;
    }
    else {
      logger.i('fetched pin');
      _userSetPIN = true;
      _correctPIN = pin;
    }
    update();
  }

  Future<void> storeNewPIN(String pin) async {
    logger.i('storing new pin');
    _storage.writeUserPIN(pin);

    // Update new PIN
    await _fetchPIN();
  }
}
