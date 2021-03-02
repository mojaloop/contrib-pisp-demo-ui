import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/account_selection_controller.dart';
import 'package:pispapp/controllers/flow/account_linking_flow_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/models/currency.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/moja_button.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class AccountSelectionScreen extends StatelessWidget {
  AccountSelectionScreen(this._accountLinkingFlowController)
      : _accountSelectionController = AccountSelectionController(
            _accountLinkingFlowController.consent.accounts);

  final AccountLinkingFlowController _accountLinkingFlowController;
  final AccountSelectionController _accountSelectionController;

  // For when there are no accounts associated with the opaque id
  Widget _buildEmptyDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.warning, size: 80, color: LightColor.lightNavyBlue),
          TitleText(
            'Oops...there are no accounts associated with that ID!',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(Account acc) {
    final String accId = acc?.accountNickname ?? 'Unknown Account';
    final String currencyStr =
        acc?.currency?.toJsonString() ?? 'Unknown Currency';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ShadowBox(
        color: LightColor.navyBlue1,
        child: ListTile(
          leading: const Icon(Icons.account_circle,
              size: 50, color: LightColor.navyBlue1),
          trailing: GetBuilder<AccountSelectionController>(
              init: _accountSelectionController,
              global: false,
              builder: (controller) {
                return controller.isAccSelected(acc)
                    ? const Icon(Icons.check_circle_outline,
                        color: LightColor.navyBlue1)
                    : const Text('');
              }),
          title: Text(accId),
          subtitle: Text(currencyStr),
          onTap: () => _accountSelectionController.onTap(acc),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return GetBuilder<AccountLinkingFlowController>(
      init: _accountLinkingFlowController,
      global: false,
      builder: (controller) {
        if (!controller.isAwaitingUpdate) {
          return MojaButton(
            const TitleText(
              'Set PIN',
              color: Colors.white,
              fontSize: 20,
            ),
            onTap: () {
              controller.initiateConsentRequest(
                _accountSelectionController.getSelectedAccounts(),
                _accountSelectionController.getSelectedScopes(),
              );
            },
          );
        } else {
          return MojaButton(
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
      child: Text('Please select the account(s) you want to link.',
          textAlign: TextAlign.center),
    );
  }

  Widget _buildList() {
    final List<Account> associatedAccounts =
        _accountSelectionController.associatedAccounts;
    if (associatedAccounts.isEmpty) {
      return _buildEmptyDisplay();
    }

    final int listLength = associatedAccounts.length + 2;
    return ListView.builder(
      itemCount: listLength,
      itemBuilder: (BuildContext ctxt, int index) {
        // Top shows a description
        if (index == 0) {
          return _buildInstructions();
        }
        // Bottom part is a "Link Account(s)" button
        else if (index == listLength - 1) {
          return _buildActionButton();
        } else {
          return _buildListItem(associatedAccounts[index - 1]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Accounts'),
      ),
      body: SizedBox.expand(
        child: _buildList(),
      ),
    );
  }
}
