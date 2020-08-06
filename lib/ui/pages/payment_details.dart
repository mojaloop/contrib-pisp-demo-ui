import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_details_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_finalize_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/shadow_heading.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PaymentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 60, 0, 30),
                child: TitleText(
                  text: 'Transaction Details',
                  fontSize: 20,
                ),
              ),
              ShadowBox(
                child: Column(
                  children: <Widget>[
                    ShadowBoxHeading('Payment Account'),
                    ListTile(
                      leading: const CircleAvatar(),
                      contentPadding: const EdgeInsets.symmetric(),
                      title: TitleText(
                        text: Get.find<PaymentFinalizeController>()
                            .selectedAccount
                            .alias,
                        fontSize: 18,
                      ),
                      subtitle: Text(
                        Get.find<PaymentFinalizeController>()
                            .selectedAccount
                            .fspInfo
                            .fspName,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(children: <Widget>[
                    Icon(Icons.arrow_downward),
                    Icon(Icons.arrow_downward),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TitleText(
                          text:
                              '${Get.find<PaymentFinalizeController>().transactionAmount} \$',
                          fontSize: 40),
                    ),
                    Icon(Icons.arrow_downward),
                    Icon(Icons.arrow_downward),
                  ]),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ShadowBox(
                child: Column(
                  children: <Widget>[
                    ShadowBoxHeading('Payee Details'),
                    ListTile(
                      leading: const CircleAvatar(),
                      contentPadding: const EdgeInsets.symmetric(),
                      title: TitleText(
                        text: Get.find<LookupPayeeController>().payeeName,
                        fontSize: 18,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(),
                      title: const TitleText(
                        text: 'Phone Number',
                        fontSize: 18,
                      ),
                      trailing: Text(Get.find<PaymentInitiateController>()
                              .phoneIsoCode +
                          Get.find<PaymentInitiateController>().phoneNumber),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GetBuilder<PaymentDetailsController>(
                  builder: (value) => value.isSubmitting
                      ? ButtonTheme(
                          minWidth: Get.width,
                          height: 70.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () =>
                                Get.find<PaymentDetailsController>()
                                    .onMakePayment(),
                            color: LightColor.navyBlue1,
                            textColor: Colors.white,
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : ButtonTheme(
                          minWidth: Get.width,
                          height: 70.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () =>
                                Get.find<PaymentDetailsController>()
                                    .onMakePayment(),
                            color: LightColor.navyBlue1,
                            textColor: Colors.white,
                            child: const TitleText(
                              text: 'Make Payment',
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
