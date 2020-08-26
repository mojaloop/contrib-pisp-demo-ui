import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/repositories/firebase/auth_repository.dart';
import 'package:pispapp/repositories/firebase/transaction_repository.dart';
import 'package:pispapp/routes/app_navigator.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockTransactionRepository extends Mock implements TransactionRepository {}

class MockCustomNavigator extends Mock implements AppNavigator {}

void main() {
  // AuthRepository authRepository;
  // AuthController authController;
  // AppNavigator navigator;
  // TransactionRepository transactionRepository;
  // PaymentInitiationController paymentInitiateController;

  setUp(
    () async {
      // authRepository = MockAuthRepository();
      // authController = AuthController(authRepository);
      // navigator = MockCustomNavigator();
      // transactionRepository = MockTransactionRepository();
      // paymentInitiateController =
      //     PaymentInitiationController(transactionRepository);
      // // sign in with google
      // when(authRepository.signInWithGoogle()).thenAnswer(
      //   (_) => Future.value(
      //     User(
      //       id: 'asd67aAhsda768AS',
      //       name: 'John Doe',
      //       email: 'jdoe@example.com',
      //     ),
      //   ),
      // );
      // await authController.signInWithGoogle();
      // Get.put(navigator);
      // Get.put(authController);

      // paymentInitiateController.validPhoneNumber = true;
      // paymentInitiateController.phoneIsoCode = 'IN';
      // paymentInitiateController.phoneNumber = '9999999999';
      // await paymentInitiateController.onPayNow();
    },
  );

  test(
    'onPayNow() with valid phone number initiates transaction ,calls setupTransactionStream and navigates to LookupPayee',
    () async {
      // verify(
      //     transactionRepository.initiate('asd67aAhsda768AS', 'IN9999999999'));
      // verify(navigator.toNamed('/transfer/lookup'));
    },
  );
}
