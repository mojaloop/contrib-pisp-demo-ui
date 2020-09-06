import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/account_unlinking_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/repositories/firebase/consent_repository.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

// ignore: must_be_immutable
class AccountUnlinking extends StatelessWidget {
  final AccountUnlinkingController _accountUnlinkingController =
      AccountUnlinkingController(ConsentRepository());

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

  Widget _buildSpinner() {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(LightColor.lightNavyBlue),
    );
  }

  Widget _buildListItem(Account acc) {
    final String accId = acc?.id ?? 'Unknown Account';
    final String currencyStr =
        acc?.currency?.toJsonString() ?? 'Unknown Currency';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ShadowBox(
        color: LightColor.navyBlue1,
        child: ListTile(
          leading: const Icon(Icons.account_circle,
              size: 50, color: LightColor.navyBlue1),
          trailing: GetBuilder<AccountUnlinkingController>(
              init: _accountUnlinkingController,
              global: false,
              builder: (controller) {
                return _accountUnlinkingController.isAwaitingUpdate &&
                        _accountUnlinkingController.selectedAccountId == accId
                    ? Container(child: _buildSpinner(), height: 25, width: 25)
                    : const Icon(Icons.remove_circle_outline,
                        color: Colors.red, size: 25);
              }),
          title: Text(accId),
          subtitle: Text(currencyStr),
          onTap: _accountUnlinkingController.selectedAccountId == null
              ? () => _accountUnlinkingController.onTap(accId)
              : null,
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Text('Please tap on the account you would like to remove:',
          textAlign: TextAlign.left),
    );
  }

  Widget _buildList() {
    return Obx(() {
      final List<Account> associatedAccounts =
          _accountUnlinkingController.accounts.value;
      if (associatedAccounts.isEmpty) {
        return _buildEmptyDisplay();
      }

      final int listLength = associatedAccounts.length + 1;
      return ListView.builder(
        itemCount: listLength,
        itemBuilder: (BuildContext ctxt, int index) {
          // Top shows a description
          if (index == 0) {
            return _buildInstructions();
          } else {
            return _buildListItem(associatedAccounts[index - 1]);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove Account'),
      ),
      body: SizedBox.expand(
        child: _buildList(),
      ),
    );
  }
}
