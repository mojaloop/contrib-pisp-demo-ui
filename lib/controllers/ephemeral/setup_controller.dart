import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/routes/app_navigator.dart';

class SetupController extends GetxController {
  PhoneNumber phoneNumber;

  bool googleLogin = false;
  bool googleLoginPrompt = false;

  final AuthController _ac = Get.find<AuthController>();
  void defaultState() {
    googleLogin = false;
    googleLoginPrompt = false;
    update();
  }

  void onPhoneNumberChange(PhoneNumber phoneNumber) {
    this.phoneNumber = phoneNumber;
    Get.find<AuthController>().setPhoneNumber(phoneNumber);
    update();
  }

  Future<void> onLinkGoogleAccount() async {
    final _ = await Get.find<AuthController>().signInWithGoogle();
    googleLogin = true;
    googleLoginPrompt = false;
    update();
  }

  void onTapNext() {
    if (!googleLogin) {
      googleLoginPrompt = true;
      update();
      return;
    }
    if(_ac.phoneNumber != null) {
      Get.find<AppNavigator>().offAllNamed('/dashboard');
    }
    else {
      Get.find<AppNavigator>().toNamed('/phone_number');
    }
  }

  void onLogin() {
    Get.find<AppNavigator>().offAllNamed('/dashboard');
  }
}
