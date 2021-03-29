import 'package:get/get.dart';

class OTPAuthController extends GetxController {
  OTPAuthController(this.onOTPFieldChanged);
  String otp;

  Function onOTPFieldChanged;

  void onOTPChanged(String otp) {
    this.otp = otp;
    onOTPFieldChanged(otp);
  }
}
