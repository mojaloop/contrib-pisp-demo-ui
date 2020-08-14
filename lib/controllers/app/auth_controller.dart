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

  User user;

  Future<void> loadAndPopulateCurrentUserInfo() async {
    User u = await _authRepository.loadCurrentUserInfo();
    print('KZ phone no: ${u.phoneNo}');
    // Currently only phone number but can be extended to populate other fields
    setPhoneNumber(u.phoneNo, u.phoneNoIso);
  }

  void setPhoneNumber(String number, String isoCode) {
    user.phoneNo = number;
    user.phoneNoIso = isoCode;
    update();
  }

  void associatePhoneNumberWithUser(String number, String isoCode) {
    _authRepository.associateUserWithPhoneNumber(user.uid, isoCode, number);
  }

  String getFormattedPhoneNoForDisplay() {
    if(user == null) {
      return '';
    }
    final String phoneIso = user.phoneNoIso ?? '';
    final String phoneNo = user.phoneNo ?? '';
    return phoneIso + phoneNo;
  }

  void setUser(User u) {
    user = u;
    update();
  }
}
