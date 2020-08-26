import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';

class PaymentConfirmationController extends GetxController {
  Money transactionAmount;

  bool transactionAmountPrompt = false;

  Account selectedAccount;

  bool noAccounts = false;

  @override
  void onInit() {
    _reloadAccounts();
    super.onInit();
  }

  void onTransactionAmountUpdate(Money amount) {
    transactionAmount = amount;
    update();
  }

  Future<void> onRefresh() async {
    await Get.find<AccountController>().getLinkedAccounts();
    _reloadAccounts();
    update();
  }

  void onAccountTileTap(Account account) {
    selectedAccount = account;
    update();
  }

  void _reloadAccounts() {
    if (Get.find<AccountController>().accounts.isEmpty) {
      noAccounts = true;
    } else {
      noAccounts = false;
      selectedAccount = Get.find<AccountController>().accounts.elementAt(0);
    }
  }
}
