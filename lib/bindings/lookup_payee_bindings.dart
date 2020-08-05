import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/repositories/stubs/stub_account_repository.dart';

class LookupPayeeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LookupPayeeController>(
        LookupPayeeController(StubAccountRepository()));
  }
}
