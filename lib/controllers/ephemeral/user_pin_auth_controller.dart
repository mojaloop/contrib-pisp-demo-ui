import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PINAuthController extends GetxController {
  // Constructor to fetch PIN automatically
  PINAuthController() {
    _fetchPIN();
  }

  // Constants
  static const String key = 'USER_PIN';
  static const Duration timeoutDuration = Duration(milliseconds: 1000);

  // Fields to be populated
  String _correctPIN = '';
  bool _userSetPIN = false;

  // Returns whether or not the user set a PIN
  bool get userSetPIN => _userSetPIN;

  // Synchronous

  // Called after correct PIN has been populated
  bool authenticate(String pin) {
    // TODO: Implement actual authentication logic
    if (pin == _correctPIN) {
      return true;
    }
    return false;
  }

  Future<void> _fetchPIN() async {
    final SharedPreferences pref = await Future.any([
      SharedPreferences.getInstance(),
      Future.delayed(PINAuthController.timeoutDuration, () => null)
    ]);

    // TODO: Throw some kind of exception
    if (pref == null) {
      return;
    }

    if (pref.containsKey(PINAuthController.key)) {
      String pin = pref.get(PINAuthController.key).toString();
      print(pin);
      _userSetPIN = true;
      _correctPIN = pin;
    } else {
      _userSetPIN = false;
    }
  }

  Future<void> storeNewPIN(String pin) async {
    print('storing new pin $pin');
    final SharedPreferences pref = await Future.any([
      SharedPreferences.getInstance(),
      Future.delayed(PINAuthController.timeoutDuration, () => null)
    ]);

    // TODO: Throw some kind of exception
    if (pref == null) {
      return;
    }

    await pref.setString(PINAuthController.key, pin);
    // Update new PIN
    await _fetchPIN();
  }
}
