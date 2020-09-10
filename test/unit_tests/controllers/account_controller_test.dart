import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/firebase/auth_repository.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AuthRepository authRepository;
  AccountController accountController;
  IAccountRepository accountRepository;
  AuthController authController;

  setUp(
    () async {
      authRepository = MockAuthRepository();
      accountRepository = MockAccountRepository();
      accountController = AccountController(accountRepository);
      authController = AuthController(authRepository);
      Get.put(authController);

      // sign into google
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
    },
  );

  test(
    'getAllLinkedAccounts() calls the AccountRepository.getUserAccounts() with signed in user uid',
    () async {
      // Call required function
      await accountController.getLinkedAccounts();

      // Check if the repository function was called with right arguments
      verify(accountRepository.getUserAccounts(authController.user.id));
    },
  );
}
