import 'dart:async';
import 'package:get/get.dart';
import 'package:pispapp/models/phone_number.dart';

class PaymentInitiationController extends GetxController {
  PaymentInitiationController();

  PISPPhoneNumber phoneNumber;

  RxBool validPhoneNumber = false.obs;

  void onPhoneNumberChange(PISPPhoneNumber phoneNumber, bool valid) {
    this.phoneNumber = phoneNumber;
    validPhoneNumber.value = valid;
    update();
  }

  Future<void> onPayNow() async {
    update();
  }
}
