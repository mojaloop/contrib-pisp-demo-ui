import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/fsp_info.dart';
import 'package:pispapp/models/party_id_info.dart';

import 'model.dart';
part 'account.g.dart';

@JsonSerializable(explicitToJson: true)
class Account extends Equatable implements Model {
  Account(
      {this.alias,
      this.userId,
      this.consentId,
      this.sourceAccountId,
      this.partyInfo,
      this.fspInfo});

  @override
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  String userId, consentId, alias, sourceAccountId;
  PartyIdInfo partyInfo;
  FspInfo fspInfo;

  @override
  List<Object> get props => [userId, consentId, alias, sourceAccountId, partyInfo, fspInfo];
}
