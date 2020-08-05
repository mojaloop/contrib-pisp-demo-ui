import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_verdict_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PaymentVerdict extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<PaymentVerdictController>(
        builder: (value) {
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
              child: value.isLoading == false
                  ? (value.success
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              SizedBox(height: 40),
                              Icon(Icons.check_circle_outline, size: 40),
                              TitleText(
                                text: 'Successful',
                                color: LightColor.yellow2,
                                fontSize: 28,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              SizedBox(height: 40),
                              Icon(Icons.error_outline, size: 40),
                              TitleText(
                                text: 'Failure',
                                color: Colors.red,
                                fontSize: 28,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ))
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
