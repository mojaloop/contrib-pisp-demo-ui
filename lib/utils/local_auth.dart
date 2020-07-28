import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:pispapp/utils/log_printer.dart';

// ignore: avoid_classes_with_only_static_members
class LocalAuth {
  static final LocalAuthentication _localAuthentication = LocalAuthentication();
  static final logger = getLogger('LocalAuth');

  static Future<bool> isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      logger.e(e);
    }

    isAvailable
        ? logger.d('Biometric is available!')
        : logger.d('Biometric is unavailable.');

    return isAvailable;
  }

  static Future<void> getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      logger.e(e);
    }

    logger.d(listOfBiometrics);
  }

  static Future<bool> authenticateUser(String reason) async {
    bool isAuthenticated = false;
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
            reason,
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      logger.e(e);
    }

    isAuthenticated
        ? logger.d('User is authenticated!')
        : logger.d('User is not authenticated.');

    return isAuthenticated;
  }
}
