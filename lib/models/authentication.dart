import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';

part 'authentication.g.dart';

@JsonSerializable(explicitToJson: true)
class Authentication extends Equatable implements Model {
  Authentication({this.type, this.value});
  @override
  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
  String type;
  String value;

  @override
  List<Object> get props => [type, value];
}
