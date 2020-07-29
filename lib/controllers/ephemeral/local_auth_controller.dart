import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pispapp/controllers/ephemeral/pin_entry_controller.dart';

class LocalAuthController extends GetxController {

  static const Duration gracePeriod = Duration(seconds: 10);

  // Used to prevent duplicates when resuming onto a verification screen
  bool verificationInProgress = false;

  // TODO: Timer for cooldown

  Future<void> onUserVerificationNeeded() async {
    // If already happening, do not open more verification screens
    if(verificationInProgress) {
      return;
    }

    // Check if still within grace period

    verificationInProgress = true;
    final localAuth = LocalAuthentication();
    try {
      final bool didAuth = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Please verify your identity',
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
}