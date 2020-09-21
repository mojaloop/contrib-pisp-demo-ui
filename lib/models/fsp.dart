import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';

part 'fsp.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Fsp extends Equatable implements JsonModel {
  Fsp({this.id, this.name});

  @override
  factory Fsp.fromJson(Map<String, dynamic> json) => _$FspFromJson(json);

  ///
  ///
  final String id;

  ///
  ///
  final String name;

  @override
  Map<String, dynamic> toJson() => _$FspToJson(this);

  @override
  List<Object> get props => [id, name];
}
