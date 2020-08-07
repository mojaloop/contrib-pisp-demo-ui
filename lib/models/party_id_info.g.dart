// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_id_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyIdInfo _$PartyIdInfoFromJson(Map<String, dynamic> json) {
  return PartyIdInfo(
    fspId: json['fspId'] as String,
    partyIdType: json['partyIdType'] as String,
    partyIdentifier: json['partyIdentifier'] as String,
  );
}

Map<String, dynamic> _$PartyIdInfoToJson(PartyIdInfo instance) =>
    <String, dynamic>{
      'fspId': instance.fspId,
      'partyIdType': instance.partyIdType,
      'partyIdentifier': instance.partyIdentifier,
    };
