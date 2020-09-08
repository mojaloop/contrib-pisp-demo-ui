import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/repositories/interfaces/i_consent_repository.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

class AccountUnlinkingController extends GetxController {
  AccountUnlinkingController(this._consentRepository) {
    _loadActiveConsents();
  }

  IConsentRepository _consentRepository;

  RxBool isAwaitingUpdate = false.obs;

  // Observable list of consents
  List<Consent> consents;

  // Used to display accounts for removal
  RxList<Account> accounts = <Account>[].obs;

  // Consent that was selected for revocation
  Consent selectedConsent;

  // Account that was selected specifically
  String selectedAccountId;

  // Handles onTap for an account
  void onTap(String accId) {
    // If there is another account was selected for unlinking
    // (and still in the process of unlinking), do not initiate
    // another unlinking
    if (selectedAccountId != null) {
      return;
    }

    final Consent toRevoke = findConsentToRevoke(accId);

    // Display dialog for confirmation
    Get.defaultDialog<dynamic>(
      title: 'Remove Account?',
      confirmTextColor: Colors.white,
      cancelTextColor: LightColor.navyBlue1,
      content: Padding(
        child: _buildDialogContent(toRevoke),
        padding: const EdgeInsets.all(10),
      ),
      onConfirm: () {
        selectedAccountId = accId;
        initiateRevocation(toRevoke);
        Get.back();
      },
      onCancel: () {
        selectedAccountId = null;
      },
    );
  }

  Widget _buildDialogContent(Consent toRevoke) {
    // If the consent is associated with multiple accounts
    // inform the user that other accounts will be deleted
    // along with this one.
    // Since we revoke the consent, we revoke the consent for all the accounts.
    Widget content =
        const Text('Are you sure you wish to unlink this account?');
    if (toRevoke.accounts.length > 1) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content,
          const SizedBox(height: 10),
          const Text('Please note that the following accounts will be removed:'),
          const SizedBox(height: 10),
          // Add list of accounts that will be removed
          ...toRevoke.accounts
              .map((acc) => Text('• ${acc.id}', textAlign: TextAlign.left)),
        ],
      );
    }
    return content;
  }

  Future<void> _loadActiveConsents() async {
    // Fetch all consents and create list of accounts with it
    final String currentUserId = Get.find<AuthController>().user.id;
    consents = await _consentRepository.getActiveConsents(currentUserId);

    // Flatten the consents into the list of accounts
    accounts.value = consents.expand((element) => element.accounts).toList();
  }

  Consent findConsentToRevoke(String accId) {
    // Find Consent object linked to this accId - this is guaranteed to exist
    return consents.firstWhere((consent) =>
        consent.accounts.where((account) => account.id == accId).isNotEmpty);
  }

  /// Revokes a particular consent object associated with an accId
  Future<void> initiateRevocation(Consent toRevoke) async {
    _setAwaitingUpdate(true);

    selectedConsent = toRevoke;

    // Update status to be revokeRequested
    _consentRepository.updateData(selectedConsent.id,
        Consent(status: ConsentStatus.revokeRequested).toJson());

    // Listen for when the revoke request is fulfilled
    _startListening(selectedConsent.id);
  }

  void Function() _cancelListener;

  void _startListening(String id) {
    _cancelListener = _consentRepository.listen(id, onValue: _onConsentChange);
  }

  void _stopListening() {
    _cancelListener();
  }

  // Listen for updates in the Consent we are listening to
  void _onConsentChange(Consent consent) {
    // If consent has been successfully revoked
    if (consent.status == ConsentStatus.revoked) {
      // Inform UI of
      _setAwaitingUpdate(false);
      _stopListening();

      // Remove consent that was just successfully revoked
      consents.removeWhere((consent) => consent.id == selectedConsent.id);

      // Update the account list as well
      accounts.value = consents.expand((element) => element.accounts).toList();

      // No selected consent or account since it has been revoked already
      selectedConsent = null;
      selectedAccountId = null;
    }
  }

  // This is intended to inform the UI that the user is not expected to
  // make any action and just need to wait. For example, a circular progress
  // indicator could be displayed.
  void _setAwaitingUpdate(bool isAwaitingUpdate) =>
      this.isAwaitingUpdate.value = isAwaitingUpdate;
}
