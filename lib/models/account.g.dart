// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    alias: json['alias'] == null ? '' : json['alias'] as String,
    userId: json['userId'] as String,
    consentId: json['consentId'] as String,
    sourceAccountId: json['sourceAccountId'] as String,
    partyInfo: json['partyInfo'] == null
        ? null
        : PartyIdInfo.fromJson(json['partyInfo'] as Map<String, dynamic>),
    fspInfo: json['fspInfo'] == null
        ? null
        : Fsp.fromJson(json['fspInfo'] as Map<String, dynamic>),
    keyHandleId: List<int>.from(json['keyHandleId'] as List<dynamic>),
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('consentId', instance.consentId);
  writeNotNull('alias', instance.alias);
  writeNotNull('sourceAccountId', instance.sourceAccountId);
  writeNotNull('partyInfo', instance.partyInfo?.toJson());
  writeNotNull('fspInfo', instance.fspInfo?.toJson());
  writeNotNull('keyHandleId', instance.keyHandleId);
  return val;
}
