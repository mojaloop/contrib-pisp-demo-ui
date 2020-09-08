import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/account_discovery_controller.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/available_fsp_controller.dart';
import 'package:pispapp/controllers/flow/account_linking_flow_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/firebase/consent_repository.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/moja_button.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class AccountDiscovery extends StatelessWidget {
  AccountDiscovery(this.fspId, this.fspName);

  final String fspId;
  final String fspName;
  final AccountDiscoveryController _accountDiscoveryController =
      AccountDiscoveryController();
  final AccountLinkingFlowController _accountLinkingFlowController =
      AccountLinkingFlowController(ConsentRepository());

  Widget _buildActionSection() {
    return GetBuilder<AccountLinkingFlowController>(
      init: _accountLinkingFlowController,
      global: false,
      builder: (controller) {
        if (!controller.isAwaitingUpdate) {
          // The user is only allowed to click the button once.
          // Afterward, the state of the payment flow controller will be updated
          // to be awaiting for response. Once the response is received, the
          // flow controller is expected to bring used to another page.
          return BottomButton(
            const TitleText(
              'Lookup Account(s)',
              color: Colors.white,
              fontSize: 20,
            ),
            onTap: () {
              // Start discovering accounts associated to opaqueId
              final opaqueId = _accountDiscoveryController.opaqueId;
              _accountLinkingFlowController.initiateDiscovery(opaqueId, fspId);
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
        'Please enter the ID of the account you are trying to link.',
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
      decoration: const InputDecoration(hintText: 'Account ID'),
      style: const TextStyle(
        fontSize: 15.0,
        height: 2.0,
        color: LightColor.navyBlue2,
      ),
      onChanged: (String value) {
        _accountDiscoveryController.onIDChange(value);
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
          title: Text(fspName),
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
