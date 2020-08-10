import 'package:get/get.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/ephemeral/payment_verdict_controller.dart';
import 'package:pispapp/repositories/stubs/stub_transaction_repository.dart';
import 'package:pispapp/repositories/transaction_repository.dart';

class PaymentVerdictBinding implements Bindings {
  @override
  void dependencies() {
    if (TRANSACTION_STUB)
      Get.lazyPut<PaymentVerdictController>(
          () => PaymentVerdictController(StubTransactionRepository()));
    else
      Get.lazyPut<PaymentVerdictController>(
          () => PaymentVerdictController(TransactionRepository()));
  }
}
