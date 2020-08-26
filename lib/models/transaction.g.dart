// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    id: json['id'] as String,
    userId: json['userId'] as String,
    payee: json['payee'] == null
        ? null
        : Party.fromJson(json['payee'] as Map<String, dynamic>),
    payer: json['payer'] == null
        ? null
        : Party.fromJson(json['payer'] as Map<String, dynamic>),
    sourceAccountId: json['sourceAccountId'] as String,
    consentId: json['consentId'] as String,
    amount: json['amount'] == null
        ? null
        : Money.fromJson(json['amount'] as Map<String, dynamic>),
    authentication: json['authentication'] == null
        ? null
        : Authentication.fromJson(
            json['authentication'] as Map<String, dynamic>),
    transactionId: json['transactionId'] as String,
    transactionRequestId: json['transactionRequestId'] as String,
    completedTimestamp: json['completedTimestamp'] as String,
    quote: json['quote'] == null
        ? null
        : Quote.fromJson(json['quote'] as Map<String, dynamic>),
    responseType:
        _$enumDecodeNullable(_$ResponseTypeEnumMap, json['responseType']),
    status: _$enumDecodeNullable(_$TransactionStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('payee', instance.payee?.toJson());
  writeNotNull('payer', instance.payer?.toJson());
  writeNotNull('sourceAccountId', instance.sourceAccountId);
  writeNotNull('consentId', instance.consentId);
  writeNotNull('amount', instance.amount?.toJson());
  writeNotNull('authentication', instance.authentication?.toJson());
  writeNotNull('transactionRequestId', instance.transactionRequestId);
  writeNotNull('completedTimestamp', instance.completedTimestamp);
  writeNotNull('transactionId', instance.transactionId);
  writeNotNull('quote', instance.quote?.toJson());
  writeNotNull('responseType', _$ResponseTypeEnumMap[instance.responseType]);
  writeNotNull('status', _$TransactionStatusEnumMap[instance.status]);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ResponseTypeEnumMap = {
  ResponseType.authorized: 'AUTHORIZED',
  ResponseType.rejected: 'REJECTED',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pendingPartyLookup: 'PENDING_PARTY_LOOKUP',
  TransactionStatus.pendingPayeeConfirmation: 'PENDING_PAYEE_CONFIRMATION',
  TransactionStatus.authorizationRequired: 'AUTHORIZATION_REQUIRED',
  TransactionStatus.success: 'SUCCESS',
};

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return Quote(
    transferAmount: json['transferAmount'] == null
        ? null
        : Money.fromJson(json['transferAmount'] as Map<String, dynamic>),
    payeeFspFee: json['payeeFspFee'] == null
        ? null
        : Money.fromJson(json['payeeFspFee'] as Map<String, dynamic>),
    payeeFspCommission: json['payeeFspCommission'] == null
        ? null
        : Money.fromJson(json['payeeFspCommission'] as Map<String, dynamic>),
    expiration: json['expiration'] as String,
    condition: json['condition'] as String,
    ilpPacket: json['ilpPacket'] as String,
  );
}

Map<String, dynamic> _$QuoteToJson(Quote instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('transferAmount', instance.transferAmount?.toJson());
  writeNotNull('payeeFspFee', instance.payeeFspFee?.toJson());
  writeNotNull('payeeFspCommission', instance.payeeFspCommission?.toJson());
  writeNotNull('expiration', instance.expiration);
  writeNotNull('condition', instance.condition);
  writeNotNull('ilpPacket', instance.ilpPacket);
  return val;
}

Money _$MoneyFromJson(Map<String, dynamic> json) {
  return Money(
    json['amount'] as String,
    _$enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
  );
}

Map<String, dynamic> _$MoneyToJson(Money instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('amount', instance.amount);
  writeNotNull('currency', _$CurrencyEnumMap[instance.currency]);
  return val;
}

const _$CurrencyEnumMap = {
  Currency.SGD: 'SGD',
  Currency.USD: 'USD',
};

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) {
  return Authentication(
    type: _$enumDecodeNullable(_$AuthenticationTypeEnumMap, json['type']),
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', _$AuthenticationTypeEnumMap[instance.type]);
  writeNotNull('value', instance.value);
  return val;
}

const _$AuthenticationTypeEnumMap = {
  AuthenticationType.u2f: 'U2F',
};
