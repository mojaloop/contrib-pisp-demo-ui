import 'package:get/get.dart';
import 'package:pispapp/repositories/transaction_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class PaymentInitiateController extends GetxController {
  String phoneNumber = '';
  String phoneIsoCode = '';

  bool correctPhoneNumber = false;
  bool phoneNumberPrompt = false;
  bool transactionSubmitting = false;

  String transactionId = '';

  void defaultState() {
    phoneNumber = '';
    phoneIsoCode = '';

    correctPhoneNumber = false;
    phoneNumberPrompt = false;

    update();
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    phoneNumber = number;
    phoneIsoCode = isoCode;
    if (number.length == 10) {
      correctPhoneNumber = true;
    } else {
      correctPhoneNumber = false;
    }
    phoneNumberPrompt = false;

    update();
  }

  Future<void> onPayNow() async {
    if (!correctPhoneNumber) {
      phoneNumberPrompt = true;
      update();
      return;
    }
    transactionSubmitting = true;
    update();
    String id = await Get.find<TransactionRepository>().initiatePayment(phoneIsoCode, phoneNumber);
    final logger = getLogger('New transaction id');
    logger.d(id);
    transactionId = id;
    transactionSubmitting = false;
    update();
    Get.toNamed<dynamic>('/transfer/lookup');

  }
}
