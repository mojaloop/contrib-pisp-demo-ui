import 'package:json_annotation/json_annotation.dart';

import 'model.dart';
part 'user.g.dart';

@JsonSerializable()
class User implements Model {
  User({this.displayName, this.email, this.photoUrl});

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String displayName, email, photoUrl;
}
