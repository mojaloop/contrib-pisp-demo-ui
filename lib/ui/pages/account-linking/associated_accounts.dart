import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/controllers/flow/account_linking_flow_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';

// ignore: must_be_immutable
class AssociatedAccounts extends StatelessWidget {
  AssociatedAccounts(this._accountLinkingFlowController);

  final AccountLinkingFlowController _accountLinkingFlowController;

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
          trailing: const Icon(Icons.check_box_outline_blank), // TODO(kkzeng): Make tap select the account
          title: Text(acc.id),
          subtitle: Text(acc.currency.toJsonString()),
        ),
      ),
    );
  }

  Widget _buildList() {
    final List<Account> associatedAccounts =
        _accountLinkingFlowController.consent.accounts;
    if (associatedAccounts.isEmpty) {
      return _buildEmptyDisplay();
    }
    return ListView.builder(
      itemCount: associatedAccounts.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return _buildListItem(associatedAccounts[index]);
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
        child: _buildList(),
      ),
    );
  }
}
