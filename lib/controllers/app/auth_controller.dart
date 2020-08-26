import 'package:get/get.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/firebase/auth_repository.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  AuthRepository _authRepository;

  PhoneNumber phoneNumber;

  String registrationDate;

  AuxiliaryUserInfo auxiliaryUserInfo;

  User user;

  Future<User> signInWithGoogle() async {
    final user = await _authRepository.signInWithGoogle();
    setUser(user);
    await loadAuxiliaryInfoForUser(user.id);
    return user;
  }

  Future<void> signOut() async {
    await _authRepository.signOut(user);
    setUser(null);
  }

  Future<void> loadAuxiliaryInfoForUser(String uid) async {
    final AuxiliaryUserInfo info = await _authRepository.loadAuxiliaryInfoForUser(uid);
    if(info != null) {
      PhoneNumber p = PhoneNumber(info.phoneNoIso,info.phoneNo);
      setPhoneNumber(p);
      setUserRegistrationDate(info.registrationDate);
    }
  }

  void setPhoneNumber(PhoneNumber phoneNumber) {
    this.phoneNumber = phoneNumber;
    update();
  }

  void setUserRegistrationDate(String date) {
    registrationDate = date;
    update();
  }

  void associatePhoneNumberWithUser(PhoneNumber number, String isoCode) {
    _authRepository.associateUserWithPhoneNumber(user.id, number);
  }

  String getFormattedPhoneNoForDisplay() {
    final String phoneNoIso = phoneNumber.countryCode;
    final String phoneNo = phoneNumber.number;
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
