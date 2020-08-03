import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/models/account.dart';

class PaymentFinalizeController extends GetxController {

  String transactionAmount = '';
  bool transactionAmountPrompt = false;
  Account selectedAccount;
  bool noAccounts = false;

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }


  void onTransactionAmountChange(String amount) {
    transactionAmount = amount;
    transactionAmountPrompt = false;

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
    if(transactionAmount == '') {
      transactionAmountPrompt = true;
      update();
      return;
    }
    
    Get.toNamed<dynamic>('/transfer/details');

  }
}

