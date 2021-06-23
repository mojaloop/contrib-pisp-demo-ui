// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consent _$ConsentFromJson(Map<String, dynamic> json) {
  return Consent(
      id: json['id'] as String,
      consentId: json['consentId'] as String,
      party: json['party'] == null
          ? null
          : Party.fromJson(json['party'] as Map<String, dynamic>),
      status: _$enumDecodeNullable(_$ConsentStatusEnumMap, json['status']),
      userId: json['userId'] as String,
      consentRequestId: json['consentRequestId'] as String,
      accounts: (json['accounts'] as List)
          ?.map((e) =>
              e == null ? null : Account.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      authChannels: (json['authChannels'] as List)
          ?.map((e) => _$enumDecodeNullable(_$AuthChannelEnumMap, e))
          ?.toList(),
      authUri: json['authUri'] as String,
      authToken: json['authToken'] as String,
      initiatorId: json['initiatorId'] as String,
      participantId: json['participantId'] as String,
      scopes: (json['scopes'] as List)
          ?.map((e) => e == null
              ? null
              : CredentialScope.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      credential: json['credential'] == null
          ? null
          : Credential.fromJson(json['credential'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ConsentToJson(Consent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('consentId', instance.consentId);
  writeNotNull('party', instance.party?.toJson());
  writeNotNull('status', _$ConsentStatusEnumMap[instance.status]);
  writeNotNull('userId', instance.userId);
  writeNotNull('consentRequestId', instance.consentRequestId);
  writeNotNull(
      'accounts', instance.accounts?.map((e) => e?.toJson())?.toList());
  writeNotNull('authChannels',
      instance.authChannels?.map((e) => _$AuthChannelEnumMap[e])?.toList());
  writeNotNull('authUri', instance.authUri);
  writeNotNull('authToken', instance.authToken);
  writeNotNull('initiatorId', instance.initiatorId);
  writeNotNull('participantId', instance.participantId);
  writeNotNull('scopes', instance.scopes?.map((e) => e?.toJson())?.toList());
  writeNotNull('credential', instance.credential?.toJson());
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ConsentStatusEnumMap = {
  ConsentStatus.pendingPartyLookup: 'PENDING_PARTY_LOOKUP',
  ConsentStatus.pendingPartyConfirmation: 'PENDING_PARTY_CONFIRMATION',
  ConsentStatus.partyConfirmed: 'PARTY_CONFIRMED',
  ConsentStatus.authenticationRequired: 'AUTHENTICATION_REQUIRED',
  ConsentStatus.authenticationComplete: 'AUTHENTICATION_COMPLETE',
  ConsentStatus.consentGranted: 'CONSENT_GRANTED',
  ConsentStatus.challengeGenerated: 'CHALLENGE_GENERATED',
  ConsentStatus.challengeSigned: 'CHALLENGE_SIGNED',
  ConsentStatus.active: 'ACTIVE',
  ConsentStatus.revokeRequested: 'REVOKE_REQUESTED',
  ConsentStatus.revoked: 'REVOKED',
};

const _$AuthChannelEnumMap = {
  AuthChannel.web: 'WEB',
  AuthChannel.otp: 'OTP',
};

Credential _$CredentialFromJson(Map<String, dynamic> json) {
  return Credential(
      credentialType:
          _$enumDecodeNullable(_$CredentialTypeEnumMap, json['credentialType']),
      status: _$enumDecodeNullable(_$CredentialStatusEnumMap, json['status']),
      payload: ParsedPublicKeyCredential.fromJson(
          json['payload'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CredentialToJson(Credential instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('payload', instance.payload.toJson());
  writeNotNull(
      'credentialType', _$CredentialTypeEnumMap[instance.credentialType]);
  writeNotNull('status', _$CredentialStatusEnumMap[instance.status]);
  return val;
}

const _$CredentialTypeEnumMap = {
  CredentialType.fido: 'FIDO',
};

const _$CredentialStatusEnumMap = {
  CredentialStatus.pending: 'PENDING',
  CredentialStatus.verified: 'VERIFIED',
};

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return Challenge(
    payload: json['payload'] as String,
    signature: json['signature'] as String,
  );
}

Map<String, dynamic> _$ChallengeToJson(Challenge instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('payload', instance.payload);
  writeNotNull('signature', instance.signature);
  return val;
}

CredentialScope _$CredentialScopeFromJson(Map<String, dynamic> json) {
  return CredentialScope(
    actions: json['scope'] as List<String>,
    accountId: json['accountId'] as String,
  );
}

Map<String, dynamic> _$CredentialScopeToJson(CredentialScope instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('actions', instance.actions);
  writeNotNull('accountId', instance.accountId);
  return val;
}

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
      id: json['id'] as String,
      accountNickname: json['accountNickname'] as String,
      currency: json['currency'] as String);
}

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('currency', instance.currency);
  return val;
}
