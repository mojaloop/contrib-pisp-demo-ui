import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';
import 'package:pispapp/models/party.dart';

part 'consent.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Consent implements JsonModel {
  String id;

  String consentId;

  Party party;

  ConsentStatus status;

  String userId;

  String consentRequestId;

  List<Account> accounts;

  List<TAuthChannel> authChannels;

  String authUri;

  /**
   * Secret token generated upon authentication
   */
  String authToken;

  /**
   * Id of initiation party e.g- PISP
   */
  String initiatorId;

  /**
   * Id of participant PISP/DFSP/party
   */
  String participantId;

  /**
   * Array of Scope objects - which inform what actions are allowed for a given
   * user account
   */
  List<TCredentialScope> scopes;

  /**
   * Credential object used for authentication of consent
   */
  TCredential credential;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

enum ConsentStatus {
  /// Waiting for a callback from Mojaloop to give the payee information.
  @JsonValue('PENDING_PARTY_LOOKUP')
  pendingPartyLookup,

  /// Waiting for the user to confirm payee information and provide more
  /// details about the transaction.
  @JsonValue('PENDING_PAYEE_CONFIRMATION')
  pendingPayeeConfirmation,

  /// Waiting for the user to authorize the transaction.
  @JsonValue('AUTHORIZATION_REQUIRED')
  authorizationRequired,

  /// The transaction is successful.
  @JsonValue('ACTIVE')
  active,

  @JsonValue('REVOKED')
  revoked,
}

enum TAuthChannel {
  @JsonValue('WEB')
  web,

  @JsonValue('OTP')
  otp,
}

class TCredential {
  String id;
  TCredentialType credentialType;
  TCredentialStatus status;
  //TODO(kkzeng): Add challenge, payload fields to models once finalized
  // challenge
  // payload
}

enum TCredentialType {
  @JsonValue('FIDO')
  fido,
}

enum TCredentialStatus {
  @JsonValue('PENDING')
  pending,

  @JsonValue('ACTIVE')
  active,
}

class TCredentialScope {
  String scope;
  String accountId;
}

class Account {
  /// Address of the bank account.
  String id;

  /// Currency of the bank account.
  Currency currency;
}

enum Currency {
  SGD,
  USD,
}