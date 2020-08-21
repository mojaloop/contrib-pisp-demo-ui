// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Party _$PartyFromJson(Map<String, dynamic> json) {
  return Party(
    name: json['name'] as String,
    partyIdInfo: json['partyIdInfo'] == null
        ? null
        : PartyIdInfo.fromJson(json['partyIdInfo'] as Map<String, dynamic>),
    merchantClassificationCode: json['merchantClassificationCode'] as String,
    personalInfo: json['personalInfo'] == null
        ? null
        : PartyPersonalInfo.fromJson(
            json['personalInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic>{
      'name': instance.name,
      'partyIdInfo': instance.partyIdInfo,
      'merchantClassificationCode': instance.merchantClassificationCode,
      'personalInfo': instance.personalInfo,
    };

PartyIdInfo _$PartyIdInfoFromJson(Map<String, dynamic> json) {
  return PartyIdInfo(
    fspId: json['fspId'] as String,
    partyIdType: json['partyIdType'] as String,
    partyIdentifier: json['partyIdentifier'] as String,
  )..partySubIdOrType = json['partySubIdOrType'] as String;
}

Map<String, dynamic> _$PartyIdInfoToJson(PartyIdInfo instance) =>
    <String, dynamic>{
      'partyIdType': instance.partyIdType,
      'partyIdentifier': instance.partyIdentifier,
      'partySubIdOrType': instance.partySubIdOrType,
      'fspId': instance.fspId,
    };

PartyPersonalInfo _$PartyPersonalInfoFromJson(Map<String, dynamic> json) {
  return PartyPersonalInfo(
    complexName: json['complexName'] == null
        ? null
        : PartyComplexName.fromJson(
            json['complexName'] as Map<String, dynamic>),
    dateOfBirth: json['dateOfBirth'] as String,
  );
}

Map<String, dynamic> _$PartyPersonalInfoToJson(PartyPersonalInfo instance) =>
    <String, dynamic>{
      'complexName': instance.complexName,
      'dateOfBirth': instance.dateOfBirth,
    };

PartyComplexName _$PartyComplexNameFromJson(Map<String, dynamic> json) {
  return PartyComplexName(
    firstName: json['firstName'] as String,
    middleName: json['middleName'] as String,
    lastName: json['lastName'] as String,
  );
}

Map<String, dynamic> _$PartyComplexNameToJson(PartyComplexName instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
    };
