import 'package:equatable/equatable.dart';
import 'package:pispapp/models/amount.dart';
import 'package:pispapp/models/authentication.dart';
import 'package:pispapp/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/payee.dart';
import 'package:pispapp/models/quote.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class Transaction extends Equatable implements Model {
  Transaction({
    this.completedTimestamp,
    this.consentId,
    this.responseType,
    this.sourceAccountId,
    this.status,
    this.transactionId,
    this.transactionRequestId,
    this.userId,
    this.amount,
    this.authentication,
    this.payee,
    this.quote,
  });

  @override
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  String completedTimestamp,
      consentId,
      responseType,
      sourceAccountId,
      status,
      transactionId,
      transactionRequestId,
      userId;
  Amount amount;
  Authentication authentication;
  Payee payee;
  Quote quote;

  @override
  List<Object> get props => [
        completedTimestamp,
        consentId,
        responseType,
        sourceAccountId,
        status,
        transactionId,
        transactionRequestId,
        userId,
        amount,
        authentication,
        payee,
        quote,
      ];
}
