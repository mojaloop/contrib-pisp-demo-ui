import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model.dart';
part 'user.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class User extends Equatable implements Model {
  User({this.uid, this.displayName, this.email, this.photoUrl});

  static User fromFirebaseUser(FirebaseUser user) {
    return User(uid: user.uid, displayName: user.displayName, email: user.email, photoUrl: user.photoUrl);
  }

  @override
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String displayName, email, photoUrl, uid;

  @override
  List<Object> get props => [displayName, email, photoUrl, uid];
}
