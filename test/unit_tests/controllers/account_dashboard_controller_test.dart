import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

class MockTransactionRepository extends Mock implements ITransactionRepository {}
class MockAccountController extends Mock implements AccountController {}
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  ITransactionRepository transactionRepository;
  AccountDashboardController accDashboardController;
  AccountController accountController;
  AuthRepository authRepository;
  AuthController authController;

  setUp(
    () async {
      transactionRepository = MockTransactionRepository();
      accDashboardController =
          AccountDashboardController(transactionRepository);
      accountController = MockAccountController();
      Get.put(accountController);

      authRepository = MockAuthRepository();
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
    'getLinkedAccounts() calls AccountController.getAllLinkedAccounts()',
    () async {
      await accDashboardController.getLinkedAccounts();

      verify(accountController.getAllLinkedAccounts());
    },
  );

  test(
    'setSelectedAccount() sets selectedAccount and updateTransactions() is called correctly',
    () {
      final Account account = Account(
        alias: 'Personal',
        consentId: '555',
        userId: 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
        sourceAccountId: 'bob.fspA',
      );
      accDashboardController.setSelectedAccount(account);

      expect(accDashboardController.selectedAccount.alias, account.alias);
      expect(accDashboardController.selectedAccount.sourceAccountId,
          account.sourceAccountId);

      verify(transactionRepository.getTransactions(
          authController.user.uid, account.sourceAccountId));
    },
  );
}
