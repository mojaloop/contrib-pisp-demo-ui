import 'package:get/get.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/auth_repository.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);
  AuthRepository _authRepository;

  Future<User> signInWithGoogle() async {
    final user = await _authRepository.signInWithGoogle();
    setUser(user);
    return user;
  }

  Future<void> signOut() async {
    await _authRepository.signOutGoogle();
    setUser(null);
  }

  String phoneNoIso;
  String phoneNo;
  String registrationDate;
  User user;

  Future<void> loadAuxiliaryInfoForUser(String uid) async {
    Map<String, dynamic> userData = await _authRepository.loadAuxiliaryInfoForUser(uid);
    // Currently only phone number but can be extended to populate other fields
    final String phoneNo = userData[AuthRepository.PHONE_NO_KEY] as String;
    final String phoneNoKey = userData[AuthRepository.PHONE_NO_ISO_KEY] as String;
    final String dateRegistered = userData[AuthRepository.REGISTRATION_DATE_KEY] as String;
    setPhoneNumber(phoneNo, phoneNoKey);
    setUserRegistrationDate(dateRegistered);
  }

  void setPhoneNumber(String number, String isoCode) {
    phoneNo = number;
    phoneNoIso = isoCode;
    update();
  }

  void setUserRegistrationDate(String date) {
    registrationDate = date;
    update();
  }

  void associatePhoneNumberWithUser(String number, String isoCode) {
    _authRepository.associateUserWithPhoneNumber(user.uid, isoCode, number);
  }

  String getFormattedPhoneNoForDisplay() {
    if(phoneNoIso == null && phoneNo == null) {
      return 'n/a';
    }
    return (phoneNoIso ?? '') + (phoneNo ?? '');
  }

  String getFormattedRegistrationDate() {
    return registrationDate == null ? 'n/a' : registrationDate.split('T')[0];
  }

  void setUser(User u) {
    user = u;
    update();
  }
}
