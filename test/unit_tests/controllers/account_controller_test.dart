import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
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
            uid: 'asd67aAhsda768AS',
            displayName: 'John Doe',
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
      await accountController.getAllLinkedAccounts();

      // Check if the repository function was called with right arguments
      verify(accountRepository.getUserAccounts(authController.user.uid));
    },
  );
}
