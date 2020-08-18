// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return Quote(
    condition: json['condition'] as String,
    expiration: json['expiration'] as String,
    ilpPacket: json['ilpPacket'] as String,
    transferAmount: json['transferAmount'] == null
        ? null
        : Amount.fromJson(json['transferAmount'] as Map<String, dynamic>),
    payeeFspFee: json['payeeFspFee'] == null
        ? null
        : Amount.fromJson(json['payeeFspFee'] as Map<String, dynamic>),
    payeeFspCommission: json['payeeFspCommission'] == null
        ? null
        : Amount.fromJson(json['payeeFspCommission'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'condition': instance.condition,
      'expiration': instance.expiration,
      'ilpPacket': instance.ilpPacket,
      'transferAmount': instance.transferAmount?.toJson(),
      'payeeFspFee': instance.payeeFspFee?.toJson(),
      'payeeFspCommission': instance.payeeFspCommission?.toJson(),
    };
