import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/interfaces/i_auth_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class AuthRepository implements IAuthRepository {
  static final logger = getLogger('AuthRepository');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<User> signInWithGoogle() async {
    // Prompt user to sign in using their Google account
    final account = await _googleSignIn.signIn();

    // Retrieve the authentication object
    final authentication = await account.authentication;

    // Capture the credential from Google sign in
    final credential = GoogleAuthProvider.getCredential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    // Sign in to Firebase with the obtained credential
    final authResult = await _firebaseAuth.signInWithCredential(credential);

    logger.i('User ${authResult.user.uid} signed in.');

    return User.fromFirebase(authResult.user, LoginType.google);
  }

  @override
  Future<void> signOut(User user) async {
    switch (user.loginType) {
      case LoginType.google:
        await _googleSignIn.signOut();
        break;
    }

    logger.i('User ${user.id} signed out.');
  }
}
