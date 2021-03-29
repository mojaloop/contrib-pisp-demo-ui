import 'dart:collection';
import 'dart:html';

import 'package:get/get.dart';
import 'package:fido2_client/Fido2ClientPlugin_web.dart';
import 'package:logger/logger.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/models/party.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/interfaces/i_consent_repository.dart';
import 'package:pispapp/ui/pages/account-linking/linking_result.dart';
import 'package:pispapp/ui/pages/account-linking/account_selection_screen.dart';
import 'package:pispapp/ui/pages/account-linking/otp_auth.dart';
import 'package:pispapp/ui/pages/account-linking/register_credential.dart';
import 'package:pispapp/ui/pages/account-linking/web_auth.dart';
import 'package:pispapp/utils/log_printer.dart';

class AccountLinkingFlowController extends GetxController {
  AccountLinkingFlowController(this._consentRepository);

  static final logger = getLogger('AccountLinkingFlowController');

  IConsentRepository _consentRepository;

  bool isAwaitingUpdate = false;
  bool isValidOpaqueId = false;
  bool hasSelectedAccounts = false;
  bool hasEnteredOTP = false;

  String opaqueId;
  Consent consent;
  String documentId;

  void Function() _unsubscriber;

  void onIDChange(String _opaqueId) {
    opaqueId = _opaqueId;
    _setIsValidOpaqueId(opaqueId != null && opaqueId.trim().isNotEmpty);
  }

  void onSelectedAccountsChanged(HashSet<Account> accounts) {
    hasSelectedAccounts = accounts.isNotEmpty;
    update();
  }

  void onOTPFieldChanged(String otp) {
    hasEnteredOTP = opaqueId != null && opaqueId.trim().isNotEmpty;
    update();
  }

  /// Adds a new consent object which notifies the
  /// PISP server to initiate discovery on the accounts
  /// linked to this [opaqueId]
  Future<void> initiateDiscovery(String opaqueId, String fspId) async {
    _setAwaitingUpdate(true);

    final authController = Get.find<AuthController>();
    if (authController.user == null) {
      logger.e('authController.user is null!!!');
    }

    final User user = Get.find<AuthController>().user;
    logger.v('initiateDiscovery: user.id is ' + user.id);
    logger.v('fspId is ' + fspId);

    // Construct a new consent
    final Consent newConsent = Consent(
      participantId: fspId,
      userId: user.id,
      party: Party(
        partyIdInfo: PartyIdInfo(
          partyIdType: PartyIdType.opaque,
          partyIdentifier: opaqueId,
          fspId: fspId,
        ),
      ),
    );

    documentId = await _consentRepository.add(newConsent.toJson());

    _startListening(documentId);
  }

  Future<void> initiateConsentRequest(
      List<Account> accsToLink, List<CredentialScope> scopes) async {
    _setAwaitingUpdate(true);
    logger.w('Initiating consent request!');

    final Consent updatedConsent = Consent(
        authChannels: [AuthChannel.web, AuthChannel.otp],
        accounts: accsToLink,
        scopes: scopes,
        status: ConsentStatus.partyConfirmed);
    logger.v('updated consent is:' + updatedConsent.toJson().toString());
    await _consentRepository.updateData(documentId, updatedConsent.toJson());
  }

  Future<void> sendAuthToken(String authToken) async {
    _setAwaitingUpdate(true);

    final Consent updatedConsent = Consent(
        authToken: authToken, status: ConsentStatus.authenticationComplete);
    await _consentRepository.updateData(documentId, updatedConsent.toJson());
  }

  Future<void> signChallenge(String signedChallenge) async {
    final Fido2ClientWeb f = Fido2ClientWeb();
    final User user = Get.find<AuthController>().user;

    // rp.id depends on where we are running
    // grab the hostname
    final host = window.location.hostname;
    final options = {
      'rp': {
        'name': 'Pineapple Pay',
        'id': host.toString(),
      }
    };
    final credentialId = await f.initiateRegistration(
        challenge: '123456', userId: user.id, options: options);

    logger.w('signChallenge, credential is: ' + credentialId.toString());

    // TODO(LD): get the attestationObject
    final Credential updatedCredential = Credential(
        id: 'todo - do we need this?',
        payload: 'todo get the payload...',
        type: CredentialType.fido,
        status: CredentialStatus.pending,
        challenge: Challenge(
            payload: 'hmm we should not be sending this',
            signature: signedChallenge));
    final Consent updatedConsent = Consent(
        keyHandleId: credentialId,
        credential: updatedCredential,
        status: ConsentStatus.challengeSigned);
    await _consentRepository.updateData(documentId, updatedConsent.toJson());
  }

  void _startListening(String id) {
    _unsubscriber = _consentRepository.listen(id, onValue: _onValue);
  }

  void _stopListening() {
    _unsubscriber();
  }

  void _onValue(Consent consent) {
    logger.w('account_linking_flow_controller - _onValue called');
    // Put the document id in the model object
    consent.id = documentId;

    final oldValue = this.consent;
    // Update consent with latest change
    this.consent = consent;

    logger.w('Consent has status: ${consent.status}');

    // TODO(kkzeng): Figure out what needs to be done in each state and explore state machine library use
    switch (consent.status) {
      case ConsentStatus.pendingPartyLookup:
        break;
      case ConsentStatus.pendingPartyConfirmation:
        if (oldValue.status == ConsentStatus.pendingPartyLookup) {
          // The consent data has been updated
          _setAwaitingUpdate(false);

          // Redirect to the next stage in account linking flow
          // Display list of associated accounts
          Get.to<dynamic>(AccountSelectionScreen(this));
        }
        break;
      case ConsentStatus.authenticationRequired:
        if (oldValue.status == ConsentStatus.partyConfirmed) {
          // The consent data has been updated
          _setAwaitingUpdate(false);

          switch (consent.authChannels[0]) {
            case AuthChannel.otp:
              Get.to<dynamic>(OTPAuth(this));
              break;
            case AuthChannel.web:
              Get.to<dynamic>(WebAuth(this));
              break;
            default:
            // not supported
          }
        }
        break;
      case ConsentStatus.consentGranted:
        // break;
        // case ConsentStatus.challengeGenerated:
        // The consent data has been updated
        _setAwaitingUpdate(false);

        // Redirect to register_credential_controller
        Get.to<dynamic>(RegisterCredential(this));
        break;
      case ConsentStatus.active:
        _stopListening();
        _setAwaitingUpdate(false);
        // TODO: display some alert?
        // go back to homescreen with toast?
        // Get.find<AppNavigator>().toNamed('/dashboard');
        Get.to<dynamic>(LinkingResult(this));
        break;
      case ConsentStatus.revoked:
        _setAwaitingUpdate(false);
        _stopListening();

        Get.to<dynamic>(LinkingResult(this));
        break;
      default:
        // we are not interested in other statuses
        logger.w('The consent had an unexpected status: ${consent.status}');
        break;
    }
  }

  void _setAwaitingUpdate(bool isAwaitingUpdate) {
    // This is intended to inform the UI that the user is not expected to
    // make any action and just need to wait. For example, a circular progress
    // indicator could be displayed.
    this.isAwaitingUpdate = isAwaitingUpdate;
    update();
  }

  void _setIsValidOpaqueId(bool val) {
    isValidOpaqueId = val;
    update();
  }
}
