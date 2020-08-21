import 'package:pispapp/models/user.dart';

abstract class IAuthRepository {
  ///
  ///
  Future<User> signInWithGoogle();

  ///
  ///
  Future<void> signOut(User user);
}
