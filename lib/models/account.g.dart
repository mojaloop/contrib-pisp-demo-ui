// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    alias: json['alias'] as String,
    userId: json['userId'] as String,
    consentId: json['consentId'] as String,
    sourceAccountId: json['sourceAccountId'] as String,
    partyInfo: json['partyInfo'] == null
        ? null
        : PartyIdInfo.fromJson(json['partyInfo'] as Map<String, dynamic>),
    fspInfo: json['fspInfo'] == null
        ? null
        : Fsp.fromJson(json['fspInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'userId': instance.userId,
      'consentId': instance.consentId,
      'alias': instance.alias,
      'sourceAccountId': instance.sourceAccountId,
      'partyInfo': instance.partyInfo,
      'fspInfo': instance.fspInfo,
    };
