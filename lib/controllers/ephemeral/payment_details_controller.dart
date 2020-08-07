import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/ephemeral/payment_finalize_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

class PaymentDetailsController extends GetxController {
  PaymentDetailsController(this._transactionRepo);
  ITransactionRepository _transactionRepo;
  bool isSubmitting = false;
  Future<void> onMakePayment() async {
    final String transactionId =
        Get.find<PaymentInitiateController>().transactionId;
    isSubmitting = true;
    update();
    final String amount =
        Get.find<PaymentFinalizeController>().transactionAmount;
    final Account payerAccount =
        Get.find<PaymentFinalizeController>().selectedAccount;

    await _transactionRepo.finalizePayment(transactionId, amount, payerAccount);
    if (TRANSACTION_STUB) {
      onQuoteAvailable('5');
    }
  }


  void onQuoteAvailable(String transactionAmount) {
    Get.defaultDialog<dynamic>(
        title: 'Transaction Fee',
        textConfirm: 'Pay',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed<dynamic>('/transfer/verdict');

          isSubmitting = false;
          update();
        },
        onCancel: () {
          Get.offAllNamed<dynamic>('/dashboard');
        },
        middleText: 'Amount: $transactionAmount\n');
  }
}
