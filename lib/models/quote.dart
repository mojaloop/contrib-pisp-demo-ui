import 'package:equatable/equatable.dart';
import 'package:pispapp/models/amount.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';

part 'quote.g.dart';

@JsonSerializable(explicitToJson: true)
class Quote extends Equatable implements Model {
  Quote(
      {this.condition,
      this.expiration,
      this.ilpPacket,
      this.transferAmount,
      this.payeeFspFee,
      this.payeeFspCommission});
  @override
  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuoteToJson(this);
  String condition;
  String expiration;
  String ilpPacket;
  Amount transferAmount, payeeFspFee, payeeFspCommission;

  @override
  List<Object> get props => [condition, expiration, ilpPacket, transferAmount, payeeFspFee,payeeFspCommission];
}
