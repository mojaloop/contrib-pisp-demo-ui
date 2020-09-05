import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/models/party.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/interfaces/i_consent_repository.dart';
import 'package:pispapp/ui/pages/account-linking/associated_accounts.dart';
import 'package:pispapp/ui/pages/account-linking/otp_auth.dart';
import 'package:pispapp/ui/pages/account-linking/web_auth.dart';

class AccountUnlinkingController extends GetxController {
  AccountUnlinkingController(this._consentRepository);

  IConsentRepository _consentRepository;

  bool isAwaitingUpdate = false;

  RxList<Consent> consents = <Consent>[].obs;

  // Used to display accounts for removal
  List<Account> accounts;

  // Consent that was selected for revocation
  Consent selectedConsent;

  @override
  Future<void> onInit() async {
    await _loadActiveConsents();

    // Flatten the consents into the list of accounts
    accounts = consents.expand((element) => element.accounts).toList();

    super.onInit();
  }

  Future<void> _loadActiveConsents() async {
    // Fetch all consents and create list of accounts with it
    final String currentUserId = Get.find<AuthController>().user.id;
    consents.value = await _consentRepository.getActiveConsents(currentUserId);
  }

  /// Revokes a particular consent object associated with an accId
  Future<void> initiateRevocation(String accId) async {
    _setAwaitingUpdate(true);

    // Find Consent object linked to this accId - this is guaranteed to exist
    selectedConsent = consents.firstWhere((consent) =>
        consent.accounts.where((account) => account.id == accId).isNotEmpty);

    // TODO(kkzeng): Explore removing an account but not revoking Consent for multiple acc consents

    // Update status to be revokeRequested
    _consentRepository.updateData(
        selectedConsent.id, Consent(status: ConsentStatus.revokeRequested).toJson());

    // Listen for when the revoke request is fulfilled
    _startListening(selectedConsent.id);
  }

  void Function() _cancelListener;

  void _startListening(String id) {
    _cancelListener = _consentRepository.listen(id, onValue: _onValue);
  }

  void _stopListening() {
    _cancelListener();
  }

  void _onValue(Consent consent) {
    // Save old value for state information
    final oldValue = selectedConsent;
    // Update consent with latest change
    selectedConsent = consent;

    if(consent.status == ConsentStatus.revoked &&
        oldValue.status == ConsentStatus.revokeRequested) {
      _setAwaitingUpdate(false);
      _stopListening();

      // Remove consent that was just successfully revoked
      consents.removeWhere((consent) => consent.id == selectedConsent.id);
      selectedConsent = null;
    }
  }

  void _setAwaitingUpdate(bool isAwaitingUpdate) {
    // This is intended to inform the UI that the user is not expected to
    // make any action and just need to wait. For example, a circular progress
    // indicator could be displayed.
    this.isAwaitingUpdate = isAwaitingUpdate;
    update();
  }
}