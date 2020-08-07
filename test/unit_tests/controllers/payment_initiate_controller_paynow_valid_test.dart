import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/repositories/transaction_repository.dart';
import 'package:pispapp/routes/custom_navigator.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockTransactionRepository extends Mock implements TransactionRepository {}
class MockCustomNavigator extends Mock implements CustomNavigator{}
void main() {
  AuthRepository authRepository;
  AuthController authController;
  CustomNavigator navigator;
  TransactionRepository transactionRepository;
  PaymentInitiateController paymentInitiateController;
  setUp(
    () async {
      authRepository = MockAuthRepository();
      authController = AuthController(authRepository);
      navigator = MockCustomNavigator();
      transactionRepository = MockTransactionRepository();
      paymentInitiateController = PaymentInitiateController(transactionRepository);
      // sign in with google
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
      Get.put(navigator);
      Get.put(authController);

      paymentInitiateController.validPhoneNumber = true;
      paymentInitiateController.phoneIsoCode = 'IN';
      paymentInitiateController.phoneNumber = '9999999999';
      await paymentInitiateController.onPayNow();
      
    },
  );

  test(
    'onPayNow() with valid phone number initiates transaction ,calls setupTransactionStream and navigates to LookupPayee',
    () async {
      verify(transactionRepository.initiateTransaction('asd67aAhsda768AS', 'IN', '9999999999'));
      verify(transactionRepository.setupTransactionStream(any));
      verify(navigator.toNamed('/transfer/lookup'));

    },
  );

}
