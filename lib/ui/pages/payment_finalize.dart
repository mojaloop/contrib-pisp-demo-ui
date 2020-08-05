import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_finalize_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/account_choosing_bottom_sheet.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/shadow_heading.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/utils/utils.dart';

class PaymentFinalize extends StatelessWidget {
  void _showAccountChoosingBottomSheet() {
    Get.bottomSheet<void>(
      AccountChoosingBottomSheet(
        onTap: (Account acc) {
          Get.find<PaymentFinalizeController>().onAccountTileTap(acc);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 0, 50),
              child: TitleText(
                text: 'Pay Now',
                fontSize: 20,
              ),
            ),
            GetBuilder<PaymentFinalizeController>(
              builder: (value) {
                return ShadowBox(
                  color: value.transactionAmountPrompt
                      ? Colors.red
                      : LightColor.navyBlue1,
                  child: Column(
                    children: <Widget>[
                      ShadowBoxHeading('Transaction Amount'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 170.0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(hintText: '0'),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 40.0,
                                height: 2.0,
                                color: LightColor.navyBlue2,
                              ),
                              onChanged: value.onTransactionAmountChange,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: TitleText(text: '\$', fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ShadowBox(
              child: GetBuilder<PaymentFinalizeController>(
                builder: (value) {
                  return Column(
                    children: <Widget>[
                      ShadowBoxHeading('Choose Payment Account'),
                      ListTile(
                        leading: const CircleAvatar(),
                        contentPadding: const EdgeInsets.symmetric(),
                        title: TitleText(
                          text: value.selectedAccount.alias,
                          fontSize: 18,
                        ),
                        subtitle: Text(
                          value.selectedAccount.fspInfo.fspName,
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            _showAccountChoosingBottomSheet();
                          },
                          child: Icon(
                            Icons.keyboard_arrow_right,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            BottomButton(
                TitleText(
                    text: 'Review Transaction',
                    color: Colors.white,
                    fontSize: 20), () {
              Get.find<PaymentFinalizeController>().onTapReview();
            }),
          ],
        ),
      ),
    );
  }
}
