import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/firebase/auth_repository.dart';
import 'package:pispapp/models/phone_number.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  AuthRepository authRepository;
  AuthController authController;
  setUp(
    () {
      authRepository = MockAuthRepository();
      authController = AuthController(authRepository);
    },
  );

  test(
    'signInWithGoogle() sets user correctly on success',
    () async {
      // Interact with the mock object.
      when(authRepository.signInWithGoogle()).thenAnswer(
        (_) => Future.value(
          User(
            id: 'asd67aAhsda768AS',
            name: 'John Doe',
            email: 'jdoe@example.com',
          ),
        ),
      );
      await authController.signInWithGoogle();

      // Verify the interaction.
      verify(authRepository.signInWithGoogle());

      expect(authController.user.id, 'asd67aAhsda768AS');
      expect(authController.user.name, 'John Doe');
      expect(authController.user.email, 'jdoe@example.com');
    },
  );

  test(
    'signOut() sets user to null on success',
    () async {
      final user = User(
        id: 'asd67aAhsda768AS',
        name: 'John Doe',
        email: 'jdoe@example.com',
        loginType: LoginType.google,
      );

      // Interact with the mock object.
      when(authRepository.signInWithGoogle()).thenAnswer(
        (_) => Future.value(user),
      );
      await authController.signInWithGoogle();

      // Verify the interaction.
      verify(authRepository.signInWithGoogle());

      // sign in successful
      expect(authController.user, isNot(equals(null)));

      await authController.signOut();

      // Verify the interaction.
      verify(authRepository.signOut(user));

      // sign out successful
      expect(authController.user, equals(null));
    },
  );

  test(
    'setPhoneNumber() sets the phone number correctly',
    () {
      authController.setPhoneNumber(PhoneNumber('IN', '9999999999'));
      expect(authController.phoneNumber.countryCode, 'IN');
      expect(authController.phoneNumber.number, '9999999999');
    },
  );

  test(
    'setUser() sets the user correctly',
    () {
      final User user = User(
        id: 'asd67aAhsda768AS',
        name: 'John Doe',
        email: 'jdoe@example.com',
      );

      authController.setUser(user);

      expect(authController.user.id, 'asd67aAhsda768AS');
      expect(authController.user.name, 'John Doe');
      expect(authController.user.email, 'jdoe@example.com');
    },
  );
}
