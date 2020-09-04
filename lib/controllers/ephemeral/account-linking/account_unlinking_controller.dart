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

  Consent consent;
  String documentId;

  void Function() _unsubscriber;

  void _onValue(Consent consent) {
    // Put the document id in the model object
    consent.id = documentId;

    final oldValue = this.consent;
    // Update consent with latest change
    this.consent = consent;

    //if(consent.status == )
  }

  void _setAwaitingUpdate(bool isAwaitingUpdate) {
    // This is intended to inform the UI that the user is not expected to
    // make any action and just need to wait. For example, a circular progress
    // indicator could be displayed.
    this.isAwaitingUpdate = isAwaitingUpdate;
    update();
  }
}