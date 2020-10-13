import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/fsp.dart';
import 'package:pispapp/models/model.dart';
import 'package:pispapp/models/party.dart';

part 'account.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Account extends Equatable implements Model {
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
  final String userId;

  ///
  ///
  final String consentId;

  ///
  ///
  final String alias;

  ///
  ///
  final String sourceAccountId;

  ///
  ///
  final PartyIdInfo partyInfo;

  final Fsp fspInfo;

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  List<Object> get props => [alias, userId, consentId, sourceAccountId,
    partyInfo, fspInfo];
}
