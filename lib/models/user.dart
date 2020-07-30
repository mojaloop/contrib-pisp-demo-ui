import 'package:json_annotation/json_annotation.dart';

import 'model.dart';
part 'user.g.dart';

@JsonSerializable()
class User implements Model {
<<<<<<< HEAD
  User({this.displayName, this.email, this.photourl});
=======
  User({this.displayName, this.email, this.photoUrl});
>>>>>>> master

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

<<<<<<< HEAD
  String displayName, email, photourl;
=======
  String displayName, email, photoUrl;
>>>>>>> master
}
