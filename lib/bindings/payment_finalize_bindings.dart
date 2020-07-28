import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_finalize_controller.dart';

class PaymentFinalizeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PaymentFinalizeController>(() => PaymentFinalizeController());
  }
}