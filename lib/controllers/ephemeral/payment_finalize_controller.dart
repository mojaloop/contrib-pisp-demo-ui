import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pispapp/bindings/payment_details_binding.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/pages/payment_details.dart';

class PaymentFinalizeController extends GetxController {

  String transactionAmount;
  Account selectedAccount;
  bool noAccounts = false;

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }


  void onTransactionAmountChange(String amount) {
    transactionAmount = amount;
    update();
  }

  void onRefresh() {
    Get.find<AccountController>().getAllLinkedAccounts();
    if (Get.find<AccountController>().accounts.isEmpty) {
      noAccounts = true;
    } else {
      noAccounts = false;
      setSelectedAccount(Get.find<AccountController>().accounts.elementAt(0));
    }

    update();
  }

  void setSelectedAccount(Account acc) {
    selectedAccount = acc;
    update();
  }

  void onAccountTileTap(Account acc) {
    setSelectedAccount(acc);
  }

  void onTapReview() {
    Get.toNamed<dynamic>('/transfer/details');

  }
}

