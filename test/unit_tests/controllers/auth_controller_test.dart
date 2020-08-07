import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/auth_repository.dart';

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
            uid: 'asd67aAhsda768AS',
            displayName: 'John Doe',
            email: 'jdoe@example.com',
          ),
        ),
      );
      await authController.signInWithGoogle();

      // Verify the interaction.
      verify(authRepository.signInWithGoogle());

      expect(authController.user.uid, 'asd67aAhsda768AS');
      expect(authController.user.displayName, 'John Doe');
      expect(authController.user.email, 'jdoe@example.com');
    },
  );

  test(
    'signOut() sets user to null on success',
    () async {
      // Interact with the mock object.
      when(authRepository.signInWithGoogle()).thenAnswer(
        (_) => Future.value(
          User(
            uid: 'asd67aAhsda768AS',
            displayName: 'John Doe',
            email: 'jdoe@example.com',
          ),
        ),
      );
      await authController.signInWithGoogle();

      // Verify the interaction.
      verify(authRepository.signInWithGoogle());

      // sign in successful
      expect(authController.user, isNot(equals(null)));

      await authController.signOut();

      // Verify the interaction.
      verify(authRepository.signOutGoogle());

      // sign out successful
      expect(authController.user, equals(null));
    },
  );

  test(
    'setPhoneNumber() sets the phone number correctly',
    () {
      authController.setPhoneNumber('9999999999', 'IN');
      expect(authController.phoneIsoCode, 'IN');
      expect(authController.phoneNumber, '9999999999');
    },
  );

  test(
    'setUser() sets the user correctly',
    () {
      final User user = User(
        uid: 'asd67aAhsda768AS',
        displayName: 'John Doe',
        email: 'jdoe@example.com',
      );
      authController.setUser(user);

      expect(authController.user.uid, 'asd67aAhsda768AS');
      expect(authController.user.displayName, 'John Doe');
      expect(authController.user.email, 'jdoe@example.com');
    },
  );
}
