// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    alias: json['alias'] as String,
    phoneNumber: json['phoneNumber'] as String,
    name: json['name'] as String,
    balance: json['balance'] as String,
    accountNumber: json['accountNumber'] as String,
    bankName: json['bankName'] as String,
    linked: json['linked'] as bool,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'alias': instance.alias,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'balance': instance.balance,
      'accountNumber': instance.accountNumber,
      'bankName': instance.bankName,
      'linked': instance.linked,
    };
