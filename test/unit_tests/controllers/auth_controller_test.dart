import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/firebase/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

/// NOTE: We are overriding only the part of the controller that is dependent
/// on Firestore. We are still testing the other implementations in
/// [AuthController].
class TestAuthController extends AuthController {
  TestAuthController(AuthRepository authRepository) : super(authRepository);

  @override
  Future<void> createUserDataControllerAndCreateUserEntity(User u) async {
    // do nothing in tests
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AuthRepository authRepository;
  AuthController authController;
  setUp(
    () {
      authRepository = MockAuthRepository();
      authController = TestAuthController(authRepository);
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
