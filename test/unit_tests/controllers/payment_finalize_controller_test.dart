
import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/controllers/ephemeral/payment_finalize_controller.dart';

void main() {
  PaymentFinalizeController paymentFinalizeController;
  setUp(() {
    paymentFinalizeController = PaymentFinalizeController();
  });

  test('onTransactionAmountChange()', () {
    paymentFinalizeController.onTransactionAmountChange('20');
    expect(paymentFinalizeController.transactionAmount, '20');
    expect(paymentFinalizeController.transactionAmountPrompt, false);

  });
}

