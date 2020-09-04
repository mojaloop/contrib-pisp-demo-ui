import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/fsp.dart';
import 'package:pispapp/models/model.dart';
import 'package:pispapp/models/party.dart';

part 'account.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Account implements Model {
  Account({
    this.alias,
    this.userId,
    this.consentId,
    this.sourceAccountId,
    this.partyInfo,
    this.fspInfo,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  ///
  ///
  String userId;

  ///
  ///
  String consentId;

  ///
  ///
  String alias;

  ///
  ///
  String sourceAccountId;

  ///
  ///
  PartyIdInfo partyInfo;

  Fsp fspInfo;

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
