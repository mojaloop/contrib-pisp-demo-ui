// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    completedTimestamp: json['completedTimestamp'] as String,
    consentId: json['consentId'] as String,
    responseType: json['responseType'] as String,
    sourceAccountId: json['sourceAccountId'] as String,
    status: json['status'] as String,
    transactionId: json['transactionId'] as String,
    transactionRequestId: json['transactionRequestId'] as String,
    userId: json['userId'] as String,
    amount: json['amount'] == null
        ? null
        : Amount.fromJson(json['amount'] as Map<String, dynamic>),
    authentication: json['authentication'] == null
        ? null
        : Authentication.fromJson(
            json['authentication'] as Map<String, dynamic>),
    payee: json['payee'] == null
        ? null
        : Payee.fromJson(json['payee'] as Map<String, dynamic>),
    quote: json['quote'] == null
        ? null
        : Quote.fromJson(json['quote'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'completedTimestamp': instance.completedTimestamp,
      'consentId': instance.consentId,
      'responseType': instance.responseType,
      'sourceAccountId': instance.sourceAccountId,
      'status': instance.status,
      'transactionId': instance.transactionId,
      'transactionRequestId': instance.transactionRequestId,
      'userId': instance.userId,
      'amount': instance.amount?.toJson(),
      'authentication': instance.authentication?.toJson(),
      'payee': instance.payee?.toJson(),
      'quote': instance.quote?.toJson(),
    };
