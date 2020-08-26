import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';
import 'package:pispapp/models/phone_number.dart';

import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/interfaces/i_auth_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class AuthRepository implements IAuthRepository {
  static const PHONE_NO_KEY = 'phoneNo';
  static const PHONE_NO_ISO_KEY = 'phoneNoIsoCode';
  static const REGISTRATION_DATE_KEY = 'dateRegistered';

  static final logger = getLogger('AuthRepository');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
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

    createUserEntryInDB(authResult.user.uid);

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

  @override
  Future<void> createUserEntryInDB(String uid) async {
    // Check for existing user (if this is not the first sign on)
    QuerySnapshot s = await _firestore.collection('users').getDocuments();
    final bool userExists = s.documents.where((document) => document.documentID == uid).isNotEmpty;
    if(!userExists) {
      final Map<String, dynamic> data = <String, dynamic>{
        REGISTRATION_DATE_KEY: DateTime.now().toIso8601String()
      };
      _firestore.collection('users').document(uid).setData(data);
      logger.d('Firestore entry created for $uid');
    }
  }

  Future<void> associateUserWithPhoneNumber(String uid, PhoneNumber num) async {
    final Map<String, dynamic> phoneNumberData = <String, dynamic>{
      PHONE_NO_KEY : num.number,
      PHONE_NO_ISO_KEY : num.countryCode
    };
    _firestore.collection('users').document(uid).setData(phoneNumberData, merge: true);
  }

  Future<AuxiliaryUserInfo> loadAuxiliaryInfoForUser(String uid) async {
    return _firestore.collection('users').document(uid).get().then((userEntry) {
      if(userEntry == null) {
        return null;
      }
      final Map<String, dynamic> userData = userEntry.data;
      // Currently only phone number but can be extended to populate other fields
      final String phoneNo = userData[AuthRepository.PHONE_NO_KEY] as String;
      final String phoneNoIso = userData[AuthRepository.PHONE_NO_ISO_KEY] as String;
      final String dateRegistered = userData[AuthRepository.REGISTRATION_DATE_KEY] as String;
      return AuxiliaryUserInfo(phoneNo: phoneNo, phoneNoIso: phoneNoIso, registrationDate: dateRegistered);
    });
  }
}
