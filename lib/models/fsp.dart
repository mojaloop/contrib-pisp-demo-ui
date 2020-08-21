import 'package:json_annotation/json_annotation.dart';
import 'package:pispapp/models/model.dart';

part 'fsp.g.dart';

@JsonSerializable()
class Fsp implements JsonModel {
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
}
