import 'dart:async';
import 'package:get/get.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:pispapp/models/phone_number.dart';

class PaymentInitiationController extends GetxController {
  PaymentInitiationController();

  PISPPhoneNumber phoneNumber;

  RxBool validPhoneNumber = false.obs;

  void onPhoneNumberChange(PISPPhoneNumber phoneNumber) {
    this.phoneNumber = phoneNumber;
    _checkNumberValidity();
    update();
  }

  Future<void> _checkNumberValidity() async {
    PhoneService.parsePhoneNumber(phoneNumber.number, phoneNumber.countryCode)
        .then((isValid) {
      validPhoneNumber.value = isValid;
    });
  }

  Future<void> onPayNow() async {
    update();
  }
}
