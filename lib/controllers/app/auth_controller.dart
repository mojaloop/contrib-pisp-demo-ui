import 'package:get/get.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/firebase/auth_repository.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  AuthRepository _authRepository;

  PhoneNumber phoneNumber;

  User user;

  Future<User> signInWithGoogle() async {
    final user = await _authRepository.signInWithGoogle();
    setUser(user);
    return user;
  }

  Future<void> signOut() async {
    await _authRepository.signOut(user);
    setUser(null);
  }

  void setPhoneNumber(PhoneNumber phoneNumber) {
    this.phoneNumber = phoneNumber;
    update();
  }

  void setUser(User user) {
    this.user = user;
    update();
  }
}
