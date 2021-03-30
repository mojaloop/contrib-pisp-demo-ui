import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/ephemeral/payment/payment_confirmation_controller.dart';
import 'package:pispapp/controllers/flow/payment_flow_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/account_choosing_bottom_sheet.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/shadow_heading.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/models/currency.dart';

class PaymentConfirmation extends StatelessWidget {
  PaymentConfirmation(this._paymentFlowController)
      : _paymentConfirmationController = PaymentConfirmationController(
            _paymentFlowController.onAmountFieldChanged);

  /// Controller that is passed between screens that handle
  /// the payment flow.
  final PaymentFlowController _paymentFlowController;

  /// Controller that is used to manage the states in this page.
  final PaymentConfirmationController _paymentConfirmationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 0, 50),
              child: TitleText('Payment Confirmation', fontSize: 20),
            ),
            _buildPayeeSection(_paymentFlowController.transaction),
            const SizedBox(height: 30),
            _buildTransactionAmountSection(),
            const SizedBox(height: 30),
            _buildChooseAccountSection(),
            const SizedBox(height: 30),
            _buildActionSection()
          ],
        ),
      ),
    );
  }

  Widget _buildPayeeSection(Transaction transaction) {
    return ShadowBox(
      color: LightColor.navyBlue1,
      child: Column(
        children: <Widget>[
          ShadowBoxHeading('Sending money to:'),
          Text(
            transaction.payee.name,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildTransactionAmountSection() {
    return GetBuilder<PaymentConfirmationController>(
      init: _paymentConfirmationController,
      global: false,
      builder: (controller) {
        return ShadowBox(
          color: LightColor.navyBlue1,
          child: Column(
            children: <Widget>[
              ShadowBoxHeading('Send how much?'),
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
                        onChanged: (String value) {
                          controller.onTransactionAmountUpdate(
                            Money(value, Currency.USD),
                          );
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child:
                        TitleText(Config.DEMO_DISPLAY_CURRENCY, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChooseAccountSection() {
    return ShadowBox(
      child: GetBuilder<PaymentConfirmationController>(
        init: _paymentConfirmationController,
        global: false,
        builder: (controller) {
          return Column(
            children: <Widget>[
              ShadowBoxHeading('From which linked account?'),
              ListTile(
                leading: const CircleAvatar(),
                contentPadding: const EdgeInsets.symmetric(),
                title: TitleText(
                  controller.selectedAccount.alias,
                  fontSize: 18,
                ),
                subtitle: Text(controller.selectedAccount.fspInfo.name),
                trailing: GestureDetector(
                  onTap: () => _showAccountChoosingBottomSheet(),
                  child: const Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionSection() {
    return GetBuilder<PaymentFlowController>(
      init: _paymentFlowController,
      global: false,
      builder: (controller) {
        if (!controller.hasEnteredAmount) {
          return BottomButton(
            const TitleText(
              'Next',
              color: Colors.white,
              fontSize: 20,
            ),
          );
        }

        if (!controller.isAwaitingUpdate) {
          // The user is only allowed to click the button once.
          // Afterward, the state of the payment flow controller will be updated
          // to be awaiting for response. Once the response is received, the
          // flow controller is expected to bring used to another page.
          return BottomButton(
            const TitleText(
              'Next',
              color: Colors.white,
              fontSize: 20,
            ),
            onTap: () {
              final amount = _paymentConfirmationController.transactionAmount;
              final account = _paymentConfirmationController.selectedAccount;
              // Confirm the transaction with the current value of transaction
              // amount and selected account.
              _paymentFlowController.confirm(amount, account);
            },
          );
        } else {
          // Once the user clicks the confirmation button, it will change to
          // a circular progress indicator until the mobile app receives the
          // response from the server which will include the transaction
          // quote for the user to review and give authorization. The flow
          // controller is responsible to bring the user to another page.
          return BottomButton(
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }
      },
    );
  }

  void _showAccountChoosingBottomSheet() {
    Get.bottomSheet<void>(
      AccountChoosingBottomSheet(
        onTap: (Account account) {
          _paymentConfirmationController.onAccountTileTap(account);
        },
      ),
    );
  }
}
