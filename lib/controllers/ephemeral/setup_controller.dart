import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';

class SetupController extends GetxController {
  String phoneNumber = '';
  String phoneIsoCode = '';

  bool googleLogin = false;
  bool validPhoneNumber = false;

  bool googleLoginPrompt = false;
  bool phoneNumberPrompt = false;

  void defaultState() {
    googleLogin = false;
    validPhoneNumber = false;

    googleLoginPrompt = false;
    phoneNumberPrompt = false;
    update();
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    phoneNumber = number;
    phoneIsoCode = isoCode;

    validPhoneNumber = true;
    Get.find<AuthController>().setPhoneNumber(number, isoCode);

    phoneNumberPrompt = false;

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
    Get.toNamed<dynamic>('/phone_number');
  }

  void onLogin() {
    if (!validPhoneNumber) {
      phoneNumberPrompt = true;
      update();
      return;
    }
    Get.offAllNamed<dynamic>('/dashboard');
  }
}
