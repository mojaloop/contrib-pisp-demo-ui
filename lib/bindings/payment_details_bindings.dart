import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_details_controller.dart';

class PaymentDetailsBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PaymentDetailsController>(() => PaymentDetailsController());
  }
}