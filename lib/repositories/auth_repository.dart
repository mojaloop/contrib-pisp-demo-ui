import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/utils/log_printer.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final logger = getLogger('AuthRepository');

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    _createUser(user.uid);

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    final User u = User.fromFirebaseUser(currentUser);

    logger.d('User signin: ${u.uid}');

    return u;
  }

  Future<void> _createUser(String uid) async {
    // Check for existing user (if this is not the first sign on)
    QuerySnapshot s = await _firestore.collection('users').getDocuments();
    final bool userExists = s.documents.where((document) => document.documentID == uid).isNotEmpty;
    if(!userExists) {
      final Map<String, dynamic> data = <String, dynamic>{
        'dateRegistered': DateTime.now().toIso8601String()
      };
      _firestore.collection('users').document(uid).setData(data);
      logger.d('Firestore entry created for ${uid}');
    }
  }

  Future<void> associateUserWithPhoneNumber(String uid, String phoneNoIsoCode, String phoneNo) async {
    final Map<String, dynamic> phoneNumberData = <String, dynamic>{
      'phoneNo': phoneNo,
      'phoneNoIsoCode': phoneNoIsoCode
    };
    _firestore.collection('users').document(uid).setData(phoneNumberData, merge: true);
  }

  Future<User> loadCurrentUserInfo() async {
    FirebaseUser user = await _auth.currentUser();
    _firestore.collection('users').document(user.uid).get().then((userEntry) {
      // map to a user object
      User currentUser = User.fromFirebaseUser(user);
      currentUser.phoneNo = userEntry.data['phoneNo'] as String;
      currentUser.phoneNoIso = userEntry.data['phoneNoIsoCode'] as String;
      print(currentUser.phoneNo);
      print(currentUser.phoneNoIso);
      return currentUser;
    });
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    logger.d('User sign out: ');
  }
}
