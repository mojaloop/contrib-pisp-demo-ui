import 'dart:async';

import 'package:get/get.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';
import 'package:pispapp/routes/custom_navigator.dart';
import 'package:pispapp/utils/local_auth.dart';

class PaymentVerdictController extends GetxController {
  PaymentVerdictController(this._transactionRepo);
  ITransactionRepository _transactionRepo;
  bool isLoading = true;
  bool isSuccess = false;

  @override
  void onInit() {
    getAuthorization();
  }

  void onSuccess() {
    isLoading = false;
    isSuccess = true;
    update();
    Get.find<PaymentInitiateController>().defaultState();
    Timer(const Duration(seconds: 3),
        () => Get.find<CustomNavigator>().offAllNamed('/dashboard'));
  }

  void onFailure() {
    isLoading = false;
    isSuccess = false;
    update();
    Get.find<PaymentInitiateController>().defaultState();

    Timer(const Duration(seconds: 3),
        () => Get.find<CustomNavigator>().offAllNamed('/dashboard'));
  }

  Future<void> getAuthorization() async {
    final bool isUserAuthenticated =
        await LocalAuth.authenticateUser('Please authorize to pay');
    final String transactionId =
        Get.find<PaymentInitiateController>().transactionId;
    if (isUserAuthenticated) {
      // TODO(StevenWjy): Do the signing here
      const String signedString = 'aasdasdasd';

      _transactionRepo.authorizePayment(transactionId, signedString);

      if (Config.TRANSACTION_STUB) {
        onSuccess();
      }
    } else {
      onFailure();
    }
  }
}
