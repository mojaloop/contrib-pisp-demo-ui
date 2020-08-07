import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

class PaymentInitiateController extends GetxController {
  PaymentInitiateController(this._transactionRepo);
  String phoneNumber = '';
  String phoneIsoCode = '';

  bool validPhoneNumber = false;
  bool phoneNumberPrompt = false;
  bool transactionSubmitting = false;

  String transactionId = '';
  StreamSubscription<DocumentSnapshot> transactionStream;

  ITransactionRepository _transactionRepo;

  void defaultState() {
    phoneNumber = '';
    phoneIsoCode = '';

    validPhoneNumber = false;
    phoneNumberPrompt = false;

    update();

    transactionId = '';
    if (transactionStream != null) {
      transactionStream.cancel();
    }
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    phoneNumber = number;
    phoneIsoCode = isoCode;
    if (number.length == 10) {
      validPhoneNumber = true;
    } else {
      validPhoneNumber = false;
    }
    phoneNumberPrompt = false;

    update();
  }

  Future<void> onPayNow() async {
    if (!validPhoneNumber) {
      phoneNumberPrompt = true;
      update();
      return;
    }
    transactionSubmitting = true;
    update();
    final userId = Get.find<AuthController>().user.uid;
    transactionId = await _transactionRepo.initiateTransaction(
        userId, phoneIsoCode, phoneNumber);
    transactionStream = _transactionRepo.setupTransactionStream(transactionId)
        as StreamSubscription<DocumentSnapshot>;
    transactionSubmitting = false;
    update();
    Get.toNamed<dynamic>('/transfer/lookup');
  }
}
