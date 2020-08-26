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

  /// A unique identifier for the user.
  String id;

  /// Name of the user.
  String name;

  /// Email of the user.
  String email;

  /// An endpoint that serves the photo of the user.
  String photoUrl;

  /// Login type of the user.
  LoginType loginType;
}

enum LoginType {
  google,
}
