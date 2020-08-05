import 'package:get/get.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/ephemeral/payment_details_controller.dart';
import 'package:pispapp/repositories/stubs/stub_transaction_repository.dart';
import 'package:pispapp/repositories/transaction_repository.dart';

class PaymentDetailsBinding implements Bindings{
  @override
  void dependencies() {
    if(TRANSACTION_STUB)
      Get.lazyPut<PaymentDetailsController>(() => PaymentDetailsController(StubTransactionRepository()));
    else 
      Get.lazyPut<PaymentDetailsController>(() => PaymentDetailsController(TransactionRepository()));

  }
}