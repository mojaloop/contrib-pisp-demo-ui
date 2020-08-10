import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';
import 'package:pispapp/models/party_id_info.dart';

part 'payee.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class Payee extends Equatable implements Model {
  Payee({this.name, this.partyIdInfo});

  @override
  factory Payee.fromJson(Map<String, dynamic> json) => _$PayeeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PayeeToJson(this);

  String name;
  PartyIdInfo partyIdInfo;

  @override
  List<Object> get props => [partyIdInfo];
}
