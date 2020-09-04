import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment/payment_initiation_controller.dart';
import 'package:pispapp/controllers/flow/payment_flow_controller.dart';
import 'package:pispapp/repositories/firebase/transaction_repository.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/phone_number_input.dart';
import 'package:pispapp/ui/widgets/phone_number_tile.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PaymentInitiation extends StatelessWidget {
  final _paymentFlowController = PaymentFlowController(TransactionRepository());
  final _paymentInitiationController = PaymentInitiationController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 60, 0, 30),
            child: TitleText('Pay Now', fontSize: 20),
          ),
          GetBuilder<PaymentInitiationController>(
            init: _paymentInitiationController,
            global: false,
            builder: (controller) {
              return ShadowBox(
                color: LightColor.navyBlue1,
                child: Column(
                  children: <Widget>[
                    const PhoneNumberTile(heading: 'Payee Mobile Number'),
                    PhoneNumberInput(
                      hintText: 'Enter phone number',
                      initialValue: controller.phoneNumber,
                      onUpdate: controller.onPhoneNumberChange,
                    ),
                  ],
                ),
              );
            },
          ),
          _buildActionSection(),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    return GetBuilder<PaymentFlowController>(
      init: _paymentFlowController,
      global: false,
      builder: (controller) {
        if (!controller.isAwaitingUpdate) {
          // The user is only allowed to click the button once.
          // Afterward, the state of the payment flow controller will be updated
          // to be awaiting for response. Once the response is received, the
          // flow controller is expected to bring used to another page.
          return Obx(() {
            return BottomButton(
              const TitleText(
                'Make A Transfer',
                color: Colors.white,
                fontSize: 20,
              ),
              onTap: _paymentInitiationController.validPhoneNumber.value ? () {
                final phoneNumber = _paymentInitiationController.phoneNumber;
                // Initiate a transfer to the given phone number.
                _paymentFlowController.initiate(phoneNumber);
              } : null
            );
          });
        } else {
          // Once the user clicks the button, it will change to a circular progress
          // indicator until the mobile app receives the response from the server
          // which will include the payee information. The flow controller is
          // responsible to bring user to another screen that displays the payee
          // information.
          return BottomButton(
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }
      },
    );
  }
}
