import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/routes/app_navigator.dart';

class PaymentAuthorizationController extends GetxController {
  bool isSubmitting = false;

  Future<void> onMakePayment() async {
    isSubmitting = true;
    update();
  }

  void onQuoteAvailable(String transactionAmount) {
    Get.defaultDialog<dynamic>(
      title: 'Transaction Fee',
      textConfirm: 'Pay',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.find<AppNavigator>().toNamed('/transfer/verdict');
        isSubmitting = false;
        update();
      },
      onCancel: () {
        Get.find<AppNavigator>().offAllNamed('/dashboard');
      },
      middleText: 'Amount: $transactionAmount\n',
    );
  }
}
