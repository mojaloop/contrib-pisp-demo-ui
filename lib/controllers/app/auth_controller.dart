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
  String phoneIsoCode = '';

  User user;

  void setPhoneNumber(String number, String isoCode) {
    phoneNumber = number;
    phoneIsoCode = isoCode;

    update();
  }

  void setUser(User user) {
    this.user = user;
    update();
  }
}
