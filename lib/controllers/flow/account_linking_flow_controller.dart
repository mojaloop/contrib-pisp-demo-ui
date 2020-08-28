import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/models/party.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/interfaces/i_consent_repository.dart';

class AccountLinkingFlowController extends GetxController {
  AccountLinkingFlowController(this._consentRepository);

  IConsentRepository _consentRepository;

  bool isAwaitingUpdate = false;

  Consent consent;
  String documentId;

  void Function() _unsubscriber;

  /// Adds a new consent object which notifies the
  /// PISP server to initiate discovery on the accounts
  /// linked to this [opaqueId]
  Future<void> initiateDiscovery(String opaqueId, String fspId) async {
    _setAwaitingUpdate();

    final User user = Get.find<AuthController>().user;

    // Construct a new consent
    final Consent newConsent = Consent(
      userId: user.id,
      party: Party(
        partyIdInfo: PartyIdInfo(
          partyIdType: PartyIdType.opaque,
          partyIdentifier: opaqueId,
          fspId: fspId,
        )
      )
    );

    documentId = await _consentRepository.add(newConsent.toJson());

    _startListening(documentId);
  }

  void _startListening(String id) {
    _unsubscriber = _consentRepository.listen(id, onValue: _onValue);
  }

  void _stopListening() {
    _unsubscriber();
  }

  void _onValue(Consent consent) {
    // Put the document id in the model object
    consent.id = documentId;

    final oldValue = this.consent;
    this.consent = consent;

    // TODO: (kkzeng) Figure out what needs to be done in each state
    switch(consent.status) {
      case ConsentStatus.pendingPartyLookup:
        break;
      case ConsentStatus.active:
        break;
      case ConsentStatus.authorizationRequired:
        break;
      case ConsentStatus.pendingPayeeConfirmation:
        break;
      case ConsentStatus.revoked:
        break;
    }
  }

  void _setAwaitingUpdate() {
    // Update the payment status to be waiting for further update.
    // This is intended to inform the UI that the user is not expected to
    // make any action and just need to wait. For example, a circular progress
    // indicator could be displayed.
    isAwaitingUpdate = true;
    update();
  }
}