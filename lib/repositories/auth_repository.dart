import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/utils/log_printer.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final logger = getLogger('AuthRepository');

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    final User u = User.fromJson(_mapUserToJson(user));

    logger.d('User signin: ${u.email}');

    return u;
  }

  Map<String, dynamic> _mapUserToJson(FirebaseUser user) {
    return <String, dynamic>{
      'displayName': user.displayName,
      'email': user.email,
      'photourl': user.photoUrl,
    };
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    logger.d('User sign out: ');
  }
}
