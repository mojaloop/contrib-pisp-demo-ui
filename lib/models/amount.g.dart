// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Amount _$AmountFromJson(Map<String, dynamic> json) {
  return Amount(
    amount: json['amount'] as String,
    currency: json['currency'] as String,
  );
}

Map<String, dynamic> _$AmountToJson(Amount instance) => <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
    };
