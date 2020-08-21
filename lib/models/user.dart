import 'package:firebase_auth/firebase_auth.dart';

import 'model.dart';

class User implements Model {
  User({this.id, this.name, this.email, this.photoUrl, this.loginType});

  factory User.fromFirebase(FirebaseUser user, LoginType type) {
    return User(
      id: user.uid,
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoUrl,
      loginType: type,
    );
  }

  ///
  ///
  String id;

  ///
  ///
  String name;

  ///
  ///
  String email;

  ///
  ///
  String photoUrl;

  ///
  ///
  LoginType loginType;
}

enum LoginType {
  google,
}
