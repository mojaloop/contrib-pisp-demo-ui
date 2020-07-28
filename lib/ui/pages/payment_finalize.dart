import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_finalize_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/shadow_heading.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/utils/utils.dart';

class PaymentFinalize extends StatelessWidget {

  Widget _getAccountTile(Account acc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListTile(
        onTap: () {
          Get.find<PaymentFinalizeController>().onAccountTileTap(acc);
        },
        leading: const CircleAvatar(),
        contentPadding: const EdgeInsets.symmetric(),
        title: TitleText(
          text: acc.alias,
          fontSize: 14,
        ),
        subtitle: Text(Utils.getSecretAccountNumber(acc)),
      ),
    );
  }

  void _showAccountChoosingBottomSheet() {
    Get.bottomSheet<void>(
      Container(
        height: 350.0,
        color: const Color(0xFF737373),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                20.0,
              ),
              topRight: Radius.circular(
                20.0,
              ),
            ),
          ),
          child: GetX<AccountController>(
            builder: (value) {
              return ListView(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(
                      20.0,
                    ),
                    child: TitleText(text: 'Accounts'),
                  ),
                  const Divider(
                    height: 20,
                  ),
                  for (var acc in value.accounts.value) _getAccountTile(acc)
                ],
              );
            },
          ),
        ),
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
              padding: EdgeInsets.fromLTRB(
                10,
                60,
                0,
                50,
              ),
              child: TitleText(
                text: 'Pay Now',
                fontSize: 20,
              ),
            ),
            ShadowBox(
              child: Column(
                children: <Widget>[
                  ShadowBoxHeading('Transaction Amount'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 170.0,
                        child: GetBuilder<PaymentFinalizeController>(
                          builder: (value) {
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(hintText: '0'),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 40.0,
                                height: 2.0,
                                color: LightColor.navyBlue2,
                              ),
                              onChanged: value.onTransactionAmountChange,
                            );
                          },
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
                          Utils.getSecretAccountNumber(value.selectedAccount),
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
            BottomButton('Review Transaction', () {
              Get.find<PaymentFinalizeController>().onTapReview();
            }),
          ],
        ),
      ),
    );
  }
}
