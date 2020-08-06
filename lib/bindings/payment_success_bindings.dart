import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_success_controller.dart';

class PaymentSuccessBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentSuccessController>(() => PaymentSuccessController());
  }
}
