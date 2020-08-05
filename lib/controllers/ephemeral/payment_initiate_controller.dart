import 'package:get/get.dart';

class PaymentInitiateController extends GetxController {
  String phoneNumber = '';
  String phoneIsoCode = '';

  bool validPhoneNumber = false;
  bool phoneNumberPrompt = false;

  void defaultState() {
    phoneNumber = '';
    phoneIsoCode = '';

    validPhoneNumber = false;
    phoneNumberPrompt = false;

    update();
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    phoneNumber = number;
    phoneIsoCode = isoCode;
    if (number.length == 10) {
      validPhoneNumber = true;
    } else {
      validPhoneNumber = false;
    }
    phoneNumberPrompt = false;

    update();
  }

  void onPayNow() {
    if (!validPhoneNumber) {
      phoneNumberPrompt = true;
      update();
      return;
    }
    Get.toNamed<dynamic>('/transfer/lookup');

    // Get.to<dynamic>(LookupPayee());
  }
}
