import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_details_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_finalize_controller.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/shadow_heading.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/utils/utils.dart';

class PaymentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(
                10,
                60,
                0,
                30,
              ),
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
                      Utils.getSecretAccountNumber(
                          Get.find<PaymentFinalizeController>()
                              .selectedAccount),
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
                      text: Get.find<LookupPayeeController>().payeeAccount.name,
                      fontSize: 18,
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(),
                    title: const TitleText(
                      text: 'Phone Number',
                      fontSize: 18,
                    ),
                    trailing: Text(Get.find<LookupPayeeController>()
                        .payeeAccount
                        .phoneNumber),
                  ),
                ],
              ),
            ),
            BottomButton('Make Payment',
                Get.find<PaymentDetailsController>().onMakePayment),
          ],
        ),
      ),
    );
  }
}
