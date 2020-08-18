import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/routes/custom_navigator.dart';

class SetupController extends GetxController {
  String phoneNumber = '';
  String phoneIsoCode = '';

  bool googleLogin = false;
  bool validPhoneNumber = false;

  bool googleLoginPrompt = false;
  bool phoneNumberPrompt = false;

  final AuthController _ac = Get.find<AuthController>();
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

    if (number.length == 10) {
      validPhoneNumber = true;
      _ac.setPhoneNumber(number, isoCode);
      _ac.associatePhoneNumberWithUser(number, isoCode);
    } else {
      validPhoneNumber = false;
      _ac.setPhoneNumber('', '');
    }

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
    if(_ac.phoneNo != null) {
      Get.find<CustomNavigator>().offAllNamed('/dashboard');
    }
    else {
      Get.find<CustomNavigator>().toNamed('/phone_number');
    }
  }

  void onLogin() {
    Get.find<CustomNavigator>().offAllNamed('/dashboard');
  }
}
