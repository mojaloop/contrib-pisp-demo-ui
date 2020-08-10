import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_verdict_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/failure.dart';
import 'package:pispapp/ui/widgets/success.dart';

class PaymentVerdict extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<PaymentVerdictController>(
        builder: (value) {
          return Scaffold(
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
              child: value.isLoading == false
                  ? (value.isSuccess
                      ? Success()
                      : Failure())
                  : const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(LightColor.yellow2),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
