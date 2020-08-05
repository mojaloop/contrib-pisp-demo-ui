import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/utils/local_auth.dart';

class PaymentDetailsController extends GetxController {
  Future<void> onMakePayment() async {
    final bool isUserAuthenticated =
        await LocalAuth.authenticateUser('Please authorize to pay');
    if (isUserAuthenticated) {
      Get.find<PaymentInitiateController>().defaultState();
      Get.offAllNamed<dynamic>('/transfer/success');
    } else {
      // TODO(MahidharBandaru): Handle auth failure case
    }
  }
}
