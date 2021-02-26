import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pispapp/controllers/flow/payment_flow_controller.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/models/currency.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/shadow_heading.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PaymentAuthorization extends StatelessWidget {
  PaymentAuthorization(this._paymentFlowController);

  final PaymentFlowController _paymentFlowController;

  @override
  Widget build(BuildContext context) {
    final transaction = _paymentFlowController.transaction;

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              _buildPayerSection(transaction),
              const SizedBox(height: 30),
              _buildTransferAmountSection(transaction),
              const SizedBox(height: 30),
              _buildPayeeSection(transaction),
              _buildActionSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(10, 60, 0, 30),
      child: TitleText('Transaction Details', fontSize: 20),
    );
  }

  Widget _buildPayerSection(Transaction transaction) {
    return ShadowBox(
      child: Column(
        children: <Widget>[
          ShadowBoxHeading('Payment Account'),
          ListTile(
            leading: const CircleAvatar(),
            contentPadding: const EdgeInsets.symmetric(),
            title: TitleText(transaction.sourceAccountId, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferAmountSection(Transaction transaction) {
    final transferAmount = transaction.quote.transferAmount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(children: <Widget>[
          const Icon(Icons.arrow_downward),
          const Icon(Icons.arrow_downward),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TitleText(
              '${transferAmount.currency.toJsonString()} ${transferAmount.amount}',
              fontSize: 40,
            ),
          ),
          const Icon(Icons.arrow_downward),
          const Icon(Icons.arrow_downward),
        ]),
      ],
    );
  }

  Widget _buildPayeeSection(Transaction transaction) {
    final name = transaction.payee.name;
    final phoneNumberStr = transaction.payee.partyIdInfo.partyIdentifier;

    return ShadowBox(
      child: Column(
        children: <Widget>[
          ShadowBoxHeading('Payee Details'),
          ListTile(
            leading: const CircleAvatar(),
            contentPadding: const EdgeInsets.symmetric(),
            title: TitleText(name, fontSize: 18),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(),
            title: const TitleText('Phone Number', fontSize: 18),
            trailing: Text(phoneNumberStr),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GetBuilder<PaymentFlowController>(
        init: _paymentFlowController,
        global: false,
        builder: (controller) {
          return ButtonTheme(
            minWidth: Get.width,
            height: 70.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(color: Colors.blue),
              ),
              color: LightColor.navyBlue1,
              textColor: Colors.white,
              // If the user presses the button, then we assume that the user
              // wants to authorize the transaction.
              //
              // TODO(kkzeng): what if the user wants to cancel the transaction?
              onPressed: () {
                if (!controller.isAwaitingUpdate) {
                  // Only update Firebase to perform the authorization once.
                  _paymentFlowController.authorize();
                }
              },
              // Once the button is clicked, it will change to display a circular
              // progress indicator until the moment we receive the transaction
              // result.
              child: controller.isAwaitingUpdate
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const TitleText(
                      'Authorize Payment',
                      color: Colors.white,
                      fontSize: 20,
                    ),
            ),
          );
        },
      ),
    );
  }
}
