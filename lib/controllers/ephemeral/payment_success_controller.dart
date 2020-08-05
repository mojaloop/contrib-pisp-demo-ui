import 'dart:async';

import 'package:get/get.dart';

class PaymentSuccessController extends GetxController {
  bool complete = false;

  @override
  void onInit() {
    Timer(const Duration(seconds: 1), () {
      complete = true;
      update();
    });

    Timer(const Duration(seconds: 3),
        () => Get.offAllNamed<dynamic>('/dashboard'));
  }
}
