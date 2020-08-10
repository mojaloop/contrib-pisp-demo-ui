// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payee _$PayeeFromJson(Map<String, dynamic> json) {
  return Payee(
    name: json['name'] as String,
    partyIdInfo: json['partyIdInfo'] == null
        ? null
        : PartyIdInfo.fromJson(json['partyIdInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PayeeToJson(Payee instance) => <String, dynamic>{
      'name': instance.name,
      'partyIdInfo': instance.partyIdInfo?.toJson(),
    };
