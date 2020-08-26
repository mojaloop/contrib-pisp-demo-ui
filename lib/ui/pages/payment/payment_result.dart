import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/flow/payment_flow_controller.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/routes/app_navigator.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/failure.dart';
import 'package:pispapp/ui/widgets/success.dart';

class PaymentResult extends StatelessWidget {
  PaymentResult(this._paymentFlowController);

  final PaymentFlowController _paymentFlowController;

  @override
  Widget build(BuildContext context) {
    final transaction = _paymentFlowController.transaction;
    final isSuccess = transaction.status == TransactionStatus.success;

    // This screen is only intended to last for 3 seconds before it
    // moves to the main dashboard.
    // TODO(kkzeng): Shall we use a button instead of a timer like this?
    Timer(
      const Duration(seconds: 3),
      () => Get.find<AppNavigator>().toNamed('/dashboard'),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                LightColor.navyBlue2,
                LightColor.lightBlue2,
              ],
            ),
          ),
          child: isSuccess ? Success() : Failure(),
        ),
      ),
    );
  }
}
