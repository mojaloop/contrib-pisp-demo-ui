import 'package:firebase_auth/firebase_auth.dart';
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

  String phoneNumber = '';
  String phoneNoIsoCode = '';

  User user;

  void setPhoneNumber(String number, String isoCode) {
    phoneNumber = number;
    phoneNoIsoCode = isoCode;
    _authRepository.associateUserWithPhoneNumber(user.uid, phoneNoIsoCode, phoneNumber);
    update();
  }

  void loadUserInfo() {
    _authRepository.loadUserInfo()
  }

  String getFormattedPhoneNoForDisplay() {
    return phoneNoIsoCode + ' ' + phoneNumber;
  }

  void setUser(User u) {
    user = u;
    update();
  }
}
