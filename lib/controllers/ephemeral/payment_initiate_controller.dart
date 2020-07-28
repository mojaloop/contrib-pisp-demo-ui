import 'package:get/get.dart';

class PaymentInitiateController extends GetxController {
  String phoneNumber = '';
  String phoneIsoCode = '';

  bool correctPhoneNumber = false;
  bool phoneNumberPrompt = false;

  void defaultState() {
    phoneNumber = '';
    phoneIsoCode = '';
    
    correctPhoneNumber = false;
    

    phoneNumberPrompt = false;
    update();
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    phoneNumber = number;
    phoneIsoCode = isoCode;
    if (number.length == 10) {
      correctPhoneNumber = true;
    } else {
      correctPhoneNumber = false;
    }
    phoneNumberPrompt = false;

    update();
  }

  void onPayNow() {
    if (!correctPhoneNumber) {
      phoneNumberPrompt = true;
      update();
      return;
    }
    Get.toNamed<dynamic>('/transfer/lookup');

    // Get.to<dynamic>(LookupPayee());
  }
}
