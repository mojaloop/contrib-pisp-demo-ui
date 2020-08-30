import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/associated_accounts_controller.dart';
import 'package:pispapp/controllers/flow/account_linking_flow_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/moja_button.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

// ignore: must_be_immutable
class AssociatedAccounts extends StatelessWidget {
  AssociatedAccounts(this._accountLinkingFlowController) {
    _associatedAccountsController = AssociatedAccountsController(_accountLinkingFlowController.consent.accounts);
  }

  final AccountLinkingFlowController _accountLinkingFlowController;
  AssociatedAccountsController _associatedAccountsController;

  // For when there are no accounts associated with the opaque id
  Widget _buildEmptyDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.warning, size: 80, color: LightColor.lightNavyBlue),
          Text(
            'Oops...there are no accounts associated with that ID!',
            style: GoogleFonts.muli(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(Account acc) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: ShadowBox(
        color: LightColor.navyBlue1,
        child: ListTile(
          trailing:
        GetBuilder<AssociatedAccountsController>(
            init: _associatedAccountsController,
            global: false,
            builder: (controller) {
              return controller.isAccSelected(acc.id) ?
              const Icon(Icons.check_box_outline_blank) :
              const Icon(Icons.check_box);
            }),
          title: Text(acc.id),
          subtitle: Text(acc.currency.toJsonString()),
          onTap: () => _associatedAccountsController.onTap(acc.id),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return GetBuilder<AccountLinkingFlowController>(
      init: _accountLinkingFlowController,
      global: false,
      builder: (controller) {
        if(!controller.isAwaitingUpdate) {
          return MojaButton(
              const TitleText(
                'Set PIN',
                color: Colors.white,
                fontSize: 20,
              ),
              onTap: () {
                // TODO(kkzeng): Proceed to consent request stage
              }
          );
        }
        else {
          return MojaButton(
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }
      },
    );
  }

  Widget _buildList() {
    final List<Account> associatedAccounts =
        _accountLinkingFlowController.consent.accounts;
    if (associatedAccounts.isEmpty) {
      return _buildEmptyDisplay();
    }

    final int listLength = associatedAccounts.length + 2;
    return ListView.builder(
      itemCount: listLength,
      itemBuilder: (BuildContext ctxt, int index) {
        // Top shows a description
        if(index == 0) {
          return const Text('Please select the account(s) you want to link');
        }
        // Bottom part is a "Link Account(s)" button
        else if(index == listLength - 1) {
          return _buildActionButton();
        }
        else {
          return _buildListItem(associatedAccounts[index - 1]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Associated accounts'),
      ),
      body:
      SizedBox.expand(
        child:_buildList(),
      ),
    );
  }
}
