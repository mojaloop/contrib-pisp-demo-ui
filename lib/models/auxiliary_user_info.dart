import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model.dart';
part 'auxiliary_user_info.g.dart';
@JsonSerializable()
// ignore: must_be_immutable
class AuxiliaryUserInfo extends Equatable implements Model {
  AuxiliaryUserInfo({this.registrationDate, this.phoneNoIso, this.phoneNo});

  factory AuxiliaryUserInfo.fromJson(Map<String, dynamic> json) => _$AuxiliaryUserInfoFromJson(json);

  String registrationDate;
  String phoneNoIso;
  String phoneNo;

  @override
  Map<String, dynamic> toJson() => _$AuxiliaryUserInfoToJson(this);

  @override
  List<Object> get props => [registrationDate, phoneNoIso, phoneNo];
}