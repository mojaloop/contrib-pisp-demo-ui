import 'dart:async';
import 'package:get/get.dart';
import 'package:pispapp/models/phone_number.dart';

class PaymentInitiationController extends GetxController {
  PaymentInitiationController();

  PhoneNumber phoneNumber;

  void onPhoneNumberChange(PhoneNumber phoneNumber) {
    this.phoneNumber = phoneNumber;
    update();
  }

  Future<void> onPayNow() async {
    update();
  }
}
