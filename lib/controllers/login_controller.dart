import 'package:get/get.dart';
import 'package:pispapp/controllers/auth_controller.dart';

class LoginController extends GetxController {
  String phoneNumber = '';
  String phoneIsoCode = '';

  bool googleLogin = false;
  bool correctPhoneNumber = false;

  bool googleLoginPrompt = false;
  bool phoneNumberPrompt = false;

  void defaultState() {
    googleLogin = false;
    correctPhoneNumber = false;

    googleLoginPrompt = false;
    phoneNumberPrompt = false;
    update();
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    phoneNumber = number;
    phoneIsoCode = isoCode;

    if (number.length == 10) {
      correctPhoneNumber = true;
      Get.find<AuthController>().setPhoneNumber(number, isoCode);
    } else {
      correctPhoneNumber = false;
      Get.find<AuthController>().setPhoneNumber('', '');
    }

    phoneNumberPrompt = false;

    update();
  }

  void onLogin() {
    if (!(googleLogin && correctPhoneNumber)) {
      if (!googleLogin) {
        googleLoginPrompt = true;
      }
      if (!correctPhoneNumber) {
        phoneNumberPrompt = true;
      }
      update();
      return;
    }

    Get.offAllNamed<dynamic>('/profile');
  }

  Future<void> onLinkGoogleAccount() async {
    final _ = await Get.find<AuthController>().signInWithGoogle();
    googleLogin = true;
  }
}
