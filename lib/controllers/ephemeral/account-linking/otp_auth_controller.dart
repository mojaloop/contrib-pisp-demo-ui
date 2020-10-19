import 'package:get/get.dart';

class OTPAuthController extends GetxController {
  String otp;

  void onOTPChanged(String otp) {
    this.otp = otp;
  }
}
