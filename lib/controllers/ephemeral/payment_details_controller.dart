import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_finalize_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/transaction_repository.dart';
import 'package:pispapp/utils/local_auth.dart';

class PaymentDetailsController extends GetxController {
  bool isSubmitting = false;
  Future<void> onMakePayment() async {
    final String transactionId =
        Get.find<PaymentInitiateController>().transactionId;
    isSubmitting = true;
    update();
    final String amount = Get.find<PaymentFinalizeController>().transactionAmount;
    final Account payerAccount = Get.find<PaymentFinalizeController>().selectedAccount;
    
    await Get.find<TransactionRepository>().finalizePayment(transactionId, amount, payerAccount);
    isSubmitting = false;
    update();

    
  }

  Future<void> getAuthorization(String transactionAmount) async {
    final bool isUserAuthenticated = await LocalAuth.authenticateUser('Please authorize to pay');
    final String transactionId =
        Get.find<PaymentInitiateController>().transactionId;
    if(isUserAuthenticated) {
      // TODO(StevenWjy): Do the signing here
      String signedString = 'aasdasdasd';
      
      Get.find<PaymentInitiateController>().defaultState();
      Get.find<TransactionRepository>().authorizePayment(transactionId, signedString);
      Get.offAllNamed<dynamic>('/transfer/verdict');

    }
    else {

    }
  }

}