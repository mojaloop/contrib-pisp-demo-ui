import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';
import 'model.dart';
import 'party.dart';

part 'consent.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Consent implements JsonModel {
  Consent({
    this.id,
    this.consentId,
    this.party,
    this.status,
    this.userId,
    this.consentRequestId,
    this.accounts,
    this.authChannels,
    this.authUri,
    this.authToken,
    this.initiatorId,
    this.participantId,
    this.scopes,
    this.credential,
  });

  @override
  factory Consent.fromJson(Map<String, dynamic> json) => _$ConsentFromJson(json);

  /// Internal id that is used to identify the transaction.
  String id;

  /// Common ID between the PISP and FSP for the Consent object. This tells
  /// DFSP and auth-service which consent allows the PISP to initiate
  /// transaction.
  String consentId;

  /// Information about the party that is associated with the consent.
  Party party;

  /// Information about the current status of the consent.
  ConsentStatus status;

  /// User Id provided by app
  String userId;

  /// Id required to identify a specific consent request
  String consentRequestId;

  /// List of accounts that exist for a given user
  List<Account> accounts;

  /// List of channels available for a user to authenticate themselves with
  List<AuthChannel> authChannels;

  /// If authentication channel chosed is WEB, then this is the url which a user
  /// must visit to authenticate themselves
  String authUri;

  /// Secret token generated upon authentication
  String authToken;

   /// Id of initiation party e.g - PISP
  String initiatorId;

  /// Id of participant PISP/DFSP/party
  String participantId;

  /// Array of Scope objects - which inform what actions are allowed
  /// for a given user account
  List<CredentialScope> scopes;

  /// Credential object used for authentication of consent
  Credential credential;

  @override
  Map<String, dynamic> toJson() => _$ConsentToJson(this);
}

//TODO(kkzeng): Adapt model once changes to auth-service finalized
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Credential implements JsonModel {
  Credential({
    this.id,
    this.credentialType,
    this.status,
    this.challenge,
  });

  @override
  factory Credential.fromJson(Map<String, dynamic> json) => _$CredentialFromJson(json);

  String id;
  CredentialType credentialType;
  CredentialStatus status;
  Challenge challenge;

  @override
  Map<String, dynamic> toJson() => _$CredentialToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Challenge implements JsonModel {
  Challenge({this.payload, this.signature});

  @override
  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  String payload;
  String signature;

  @override
  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CredentialScope implements JsonModel {
  CredentialScope({this.scope, this.accountId});

  @override
  factory CredentialScope.fromJson(Map<String, dynamic> json) => _$CredentialScopeFromJson(json);

  String scope;
  String accountId;

  @override
  Map<String, dynamic> toJson() => _$CredentialScopeToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Account implements JsonModel {
  Account({this.id, this.currency});

  @override
  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  /// Address of the bank account.
  String id;

  /// Currency of the bank account.
  Currency currency;

  @override
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

enum CredentialType {
  @JsonValue('FIDO')
  fido,
}

extension CredentialTypeJson on CredentialType {
  String toJsonString() {
    return _$CredentialTypeEnumMap[this];
  }
}

enum CredentialStatus {
  @JsonValue('PENDING')
  pending,

  @JsonValue('ACTIVE')
  active,
}

extension CredentialStatusJson on CredentialStatus {
  String toJsonString() {
    return _$CredentialStatusEnumMap[this];
  }
}

enum ConsentStatus {
  /// Waiting for a callback from Mojaloop to give the consent/account information.
  @JsonValue('PENDING_PARTY_LOOKUP')
  pendingPartyLookup,

  /// Waiting for the user to confirm party lookup information and select
  /// accounts to link
  @JsonValue('PENDING_PARTY_CONFIRMATION')
  pendingPartyConfirmation,

  /// Waiting for the user to authorize the account linking.
  @JsonValue('AUTHENTICATION_REQUIRED')
  authenticationRequired,

  /// Mojaloop has notified the server that consent has been granted.
  /// The user has authorized themselves.
  @JsonValue('CONSENT_GRANTED')
  consentGranted,

  /// The server has requested that Mojaloop present a challenge
  /// for the FIDO registration process.
  @JsonValue('CHALLENGE_GENERATED')
  challengeGenerated,

  /// The account linking was successful.
  @JsonValue('ACTIVE')
  active,

  @JsonValue('REVOKE_REQUESTED')
  revokeRequested,

  /// The consent was successfully revoked by the user.
  @JsonValue('REVOKED')
  revoked,
}

extension ConsentStatusJson on ConsentStatus {
  String toJsonString() {
    return _$ConsentStatusEnumMap[this];
  }
}

enum AuthChannel {
  @JsonValue('WEB')
  web,

  @JsonValue('OTP')
  otp,
}

extension AuthChannelJson on AuthChannel {
  String toJsonString() {
    return _$AuthChannelEnumMap[this];
  }
}
