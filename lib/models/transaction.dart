import 'package:pispapp/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

enum Status {
  SUCCESSFUL,
  PENDING,
  ERROR,
}

@JsonSerializable()
class Transaction implements Model {
  Transaction(
      String from, String to, String amount, String date, String payeeName, Status status)
      : _from = from,
        _to = to,
        _amount = amount,
        _date = date,
        _payeeName = payeeName,
        _status = status;

  @override
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);


  @override
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  String _from, _to, _amount, _date, _payeeName;
  Status _status;

  String get from => _from;
  String get to => _to;
  String get amount => _amount;
  String get date => _date;
  String get payeeName => _payeeName;
  Status get status => _status;
}
