import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';

part 'amount.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class Amount extends Equatable implements Model {
  Amount({this.amount, this.currency});
  @override
  factory Amount.fromJson(Map<String, dynamic> json) => _$AmountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AmountToJson(this);
  String amount;
  String currency;

  @override
  List<Object> get props => [amount, currency];
}
