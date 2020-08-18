// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auxiliary_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuxiliaryUserInfo _$AuxiliaryUserInfoFromJson(Map<String, dynamic> json) {
  return AuxiliaryUserInfo(
    registrationDate: json['registrationDate'] as String,
    phoneNoIso: json['phoneNoIso'] as String,
    phoneNo: json['phoneNo'] as String,
  );
}

Map<String, dynamic> _$AuxiliaryUserInfoToJson(AuxiliaryUserInfo instance) =>
    <String, dynamic>{
      'registrationDate': instance.registrationDate,
      'phoneNoIso': instance.phoneNoIso,
      'phoneNo': instance.phoneNo,
    };
