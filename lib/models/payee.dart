import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';
import 'package:pispapp/models/party_id_info.dart';

part 'payee.g.dart';

@JsonSerializable(explicitToJson: true)
class Payee implements Model {
  Payee({this.name, this.partyIdInfo});

  @override
  factory Payee.fromJson(Map<String, dynamic> json) => _$PayeeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PayeeToJson(this);

  String name;
  PartyIdInfo partyIdInfo;
}
