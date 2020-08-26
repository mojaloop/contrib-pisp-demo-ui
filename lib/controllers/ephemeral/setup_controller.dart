import 'package:get/get.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/routes/app_navigator.dart';

class SetupController extends GetxController {
  PhoneNumber phoneNumber;
  RxBool validPhoneNumber = false.obs;

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
    _checkNumberValidity();
    Get.find<AuthController>().setPhoneNumber(phoneNumber);
    update();
  }

  Future<void> _checkNumberValidity() async {
    PhoneService.parsePhoneNumber(phoneNumber.number, phoneNumber.countryCode).then((isValid) {
      validPhoneNumber.value = isValid;
    });
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

    // If phone number information is unknown, setup.
    // Otherwise skip straight to dashboard
    if(_ac.phoneNumber != null) {
      Get.find<AppNavigator>().offAllNamed('/dashboard');
    }
    else {
      Get.find<AppNavigator>().toNamed('/phone_number');
    }
  }

  void onPhoneNumberSubmitted() {
    Get.find<AuthController>().associatePhoneNumberWithUser(phoneNumber);
    Get.find<AppNavigator>().offAllNamed('/dashboard');
  }

  void onLogin() {
    Get.find<AppNavigator>().offAllNamed('/dashboard');
  }
}
