import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/routes/app_navigator.dart';
import 'package:pispapp/models/transaction.dart';

class PaymentConfirmationController extends GetxController {
  Money transactionAmount;

  bool transactionAmountPrompt = false;

  Account selectedAccount;

  bool noAccounts = false;

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }

  void onTransactionAmountChange(Money amount) {
    transactionAmount = amount;
    update();
  }

  void onRefresh() {
    Get.find<AccountController>().getLinkedAccounts();
    if (Get.find<AccountController>().accounts.isEmpty) {
      noAccounts = true;
    } else {
      noAccounts = false;
      setSelectedAccount(Get.find<AccountController>().accounts.elementAt(0));
    }

    update();
  }

  void setSelectedAccount(Account account) {
    selectedAccount = account;
    update();
  }

  void onAccountTileTap(Account acc) {
    setSelectedAccount(acc);
  }

  void onTapReview() {
    if (transactionAmount == '') {
      transactionAmountPrompt = true;
      update();
      return;
    }

    Get.find<AppNavigator>().toNamed('/transfer/details');
  }
}
