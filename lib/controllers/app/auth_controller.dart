import 'package:get/get.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/auth_repository.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);
  AuthRepository _authRepository;

  Future<User> signInWithGoogle() async {
    final user = await _authRepository.signInWithGoogle();
    setUser(user);
    await loadAuxiliaryInfoForUser(user.uid);
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
    final AuxiliaryUserInfo info = await _authRepository.loadAuxiliaryInfoForUser(uid);
    if(info != null) {
      setPhoneNumber(info.phoneNo, info.phoneNoIso);
      setUserRegistrationDate(info.registrationDate);
    }
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
