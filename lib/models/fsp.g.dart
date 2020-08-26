// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fsp _$FspFromJson(Map<String, dynamic> json) {
  return Fsp(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$FspToJson(Fsp instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}
