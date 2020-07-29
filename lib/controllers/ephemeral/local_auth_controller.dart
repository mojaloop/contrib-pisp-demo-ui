import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pispapp/controllers/ephemeral/pin_entry_controller.dart';

class LocalAuthController extends GetxController {

  // Timer for grace period
  static const Duration gracePeriod = Duration(seconds: 10);
  DateTime _timestamp = DateTime.now().subtract(gracePeriod);

  // Used to prevent duplicates when resuming onto a verification screen
  bool verificationInProgress = false;

  Future<void> _onUserVerificationNeeded() async {
    // If already happening, do not open more verification screens
    if(verificationInProgress) {
      return;
    }

    verificationInProgress = true;
    final localAuth = LocalAuthentication();
    try {
      final bool didAuth = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Please verify your identity',
          stickyAuth: true,
          useErrorDialogs: false);

      // Use PIN screen if biometric did not validate
      // i.e. User hit cancel
      if(!didAuth) {
        Get.find<PINEntryController>().onFallbackVerificationNeeded();
      }
      else {
        verificationInProgress = false; // Completed verification
      }
    } catch(e) {
      Get.find<PINEntryController>().onFallbackVerificationNeeded();
    }
  }

  void appWasPaused() =>_timestamp = DateTime.now();
  void appWasResumed() {
    // Check if still within grace period
    if(DateTime.now().difference(_timestamp) > gracePeriod) {
      _onUserVerificationNeeded();
    }
  }
}