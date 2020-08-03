import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_verdict_controller.dart';

class PaymentVerdictBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PaymentVerdictController>(() => PaymentVerdictController());
  }
}