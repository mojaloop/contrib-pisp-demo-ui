import 'package:get/get.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/repositories/stubs/stub_transaction_repository.dart';
import 'package:pispapp/repositories/transaction_repository.dart';

class LookupPayeeBinding implements Bindings{
  @override
  void dependencies() {
    if(STUB)
      Get.put<LookupPayeeController>(LookupPayeeController(StubTransactionRepository()));
    else 
      Get.put<LookupPayeeController>(LookupPayeeController(TransactionRepository()));

  }
}