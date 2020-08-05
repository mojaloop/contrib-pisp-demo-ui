import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_success_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PaymentSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              LightColor.navyBlue2,
              LightColor.lightBlue2,
            ],
          ),
        ),
        child: GetBuilder<PaymentSuccessController>(
          builder: (value) {
            return value.complete
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        SizedBox(height: 40),
                        TitleText(
                          text: 'Transaction Successful',
                          color: LightColor.yellow2,
                          fontSize: 28,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(LightColor.yellow2),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
