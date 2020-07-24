import 'package:pispapp/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

enum Status { 
   SUCCESSFUL, PENDING, ERROR,
}

@JsonSerializable()
class Transaction implements Model{
  Transaction(this.from, this.to, this.amount, this.date, this.payeeName, this.status);

  @override
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransactionToJson(this);



  String from, to, amount, date, payeeName;
  Status status;

  
  
}