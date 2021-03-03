import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/app/user_data_controller.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/routes/app_navigator.dart';

class SetupController extends GetxController {
  PISPPhoneNumber phoneNumber;
  RxBool validPhoneNumber = false.obs;

  bool googleLogin = false;
  bool googleLoginPrompt = false;

  // TODO - reenable one day - seems to cause rendering issues
  // @override
  // void onInit() {
  //   if (Get.find<UserDataController>().phoneNumberAssociated) {
  // phoneNumber = Get.find<UserDataController>().getPhoneNumber();
  //   validPhoneNumber.value = true;
  //   }

  //   super.onInit();
  // }

  void defaultState() {
    googleLogin = false;
    googleLoginPrompt = false;
    update();
  }

  /// Because of some web quirks,
  /// We rely on the phone number library to only call this
  /// when the number is already valid
  void onPhoneNumberChange(PISPPhoneNumber phoneNumber, bool valid) {
    print('onPhoneNumberChange? ' + phoneNumber.toString());

    this.phoneNumber = phoneNumber;
    Get.find<UserDataController>().setPhoneNumber(phoneNumber);
    validPhoneNumber.value = valid;
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

    // If phone number information has been previously associated then
    // skip the phone number setup
    // Otherwise proceed with phone number setup
    // TODO - get rid of this, instead pre-fill the user's number
    // if (Get.find<UserDataController>().phoneNumberAssociated) {
    //   Get.find<AppNavigator>().offAllNamed('/dashboard');
    // } else {
    Get.find<AppNavigator>().toNamed('/phone_number');
    // }
  }

  void onPhoneNumberSubmitted() {
    Get.find<UserDataController>().associatePhoneNumberWithUser(phoneNumber);
    Get.find<AppNavigator>().offAllNamed('/dashboard');
  }

  void onLogin() {
    Get.find<AppNavigator>().offAllNamed('/dashboard');
  }
}
