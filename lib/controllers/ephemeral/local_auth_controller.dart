import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/ephemeral/pin_entry_controller.dart';

class LocalAuthController extends GetxController {

  // Timer for grace period
  DateTime _timestamp;

  // Used to prevent duplicates when resuming onto a verification screen
  bool verificationInProgress = false;

  PINEntryController _pinEntryController = Get.put(PINEntryController());

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
        _pinEntryController.onFallbackVerificationNeeded();
      } else {
        verificationInProgress = false; // Completed verification
      }
    } catch(e) {
      _pinEntryController.onFallbackVerificationNeeded();
    }
  }

  void appWasPaused() => _timestamp = DateTime.now();

  void appWasResumed() {
    // Check if still within grace period
    final bool longerThanGracePeriod = _timestamp == null ||
        DateTime.now().difference(_timestamp) > const Duration(seconds: Config.LOCAL_AUTH_GRACE_PERIOD_SECONDS);
    if(Config.LOCAL_AUTH_PROMPT_ENABLED && longerThanGracePeriod) {
      _onUserVerificationNeeded();
    }
  }
}
