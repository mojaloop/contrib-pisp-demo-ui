import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/controllers/ephemeral/payment/payment_confirmation_controller.dart';

void main() {
  PaymentConfirmationController paymentFinalizeController;

  setUp(() {
    paymentFinalizeController = PaymentConfirmationController();
  });

  // test('onTransactionAmountChange()', () {
  //   paymentFinalizeController.onUpdateAmount('20');
  //   expect(paymentFinalizeController.transactionAmount, '20');
  //   expect(paymentFinalizeController.transactionAmountPrompt, false);
  // });
}
