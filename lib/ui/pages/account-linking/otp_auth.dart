import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/otp_auth_controller.dart';
import 'package:pispapp/controllers/flow/account_linking_flow_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class OTPAuth extends StatelessWidget {
  OTPAuth(this._accountLinkingFlowController)
      : _authController =
            OTPAuthController(_accountLinkingFlowController.onOTPFieldChanged);

  final AccountLinkingFlowController _accountLinkingFlowController;
  final OTPAuthController _authController;

  Widget _buildActionSection() {
    return GetBuilder<AccountLinkingFlowController>(
      init: _accountLinkingFlowController,
      global: false,
      builder: (controller) {
        if (!controller.hasEnteredOTP) {
          return BottomButton(const TitleText(
            'Verify',
            color: Colors.white,
            fontSize: 20,
          ));
        }

        if (!controller.isAwaitingUpdate) {
          // The user is only allowed to click the button once.
          // Afterward, the state of the payment flow controller will be updated
          // to be awaiting for response. Once the response is received, the
          // flow controller is expected to bring used to another page.
          return BottomButton(
            const TitleText(
              'Verify',
              color: Colors.white,
              fontSize: 20,
            ),
            onTap: () {
              // Send auth token back to demo server for verification
              _accountLinkingFlowController.sendAuthToken(_authController.otp);
            },
          );
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

  Widget _buildInstructions() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        'Please enter the One Time Password provided to you by your financial service provider.',
        style: TextStyle(
          fontSize: 15.0,
          color: LightColor.navyBlue2,
        ),
      ),
    );
  }

  Widget _buildIDTextField() {
    return TextField(
      textAlign: TextAlign.center,
      decoration: const InputDecoration(hintText: 'One Time Password'),
      style: const TextStyle(
        fontSize: 15.0,
        height: 2.0,
        color: LightColor.navyBlue2,
      ),
      onChanged: (String value) {
        _authController.onOTPChanged(value);
      },
    );
  }

  Widget _buildAccountIcon() {
    return const Icon(
      Icons.account_circle,
      size: 120,
      color: LightColor.lightNavyBlue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OTP Authentication'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildAccountIcon(),
              _buildInstructions(),
              _buildIDTextField(),
              _buildActionSection(),
            ],
          ),
        ));
  }
}
