// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fsp_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FspInfo _$FspInfoFromJson(Map<String, dynamic> json) {
  return FspInfo(
    fspId: json['fspId'] as String,
    fspName: json['fspName'] as String,
    fspIconUrl: json['fspIconUrl'] as String,
  );
}

Map<String, dynamic> _$FspInfoToJson(FspInfo instance) => <String, dynamic>{
      'fspId': instance.fspId,
      'fspName': instance.fspName,
      'fspIconUrl': instance.fspIconUrl,
    };
