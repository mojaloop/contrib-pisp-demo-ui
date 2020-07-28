import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/utils/local_auth.dart';
import 'package:pispapp/utils/utils.dart';

class PaymentDetailsController extends GetxController {
  void onMakePayment() async {
    bool isUserAuthenticated = await LocalAuth.authenticateUser('Please authorize to pay');
    if(isUserAuthenticated) {
      Get.find<PaymentInitiateController>().defaultState();
      Get.offAllNamed<dynamic>('/dashboard');

    }
    else {

    }
  }

}