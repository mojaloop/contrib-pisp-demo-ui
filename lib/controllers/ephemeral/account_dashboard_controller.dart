import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class AccountDashboardController extends GetxController {
  AccountDashboardController(this._transactionRepo);
  Account selectedAccount;
  List<Transaction> transactionList = <Transaction>[];

  ITransactionRepository _transactionRepo;
  bool noAccounts = true;

  Future<void> onRefresh() async {
    await getLinkedAccounts();
    if (Get.find<AccountController>().accounts.isEmpty) {
      noAccounts = true;
    } else {
      noAccounts = false;
      setSelectedAccount(Get.find<AccountController>().accounts.elementAt(0));
    }

    update();
  }

  void onAccountTileTap(Account acc) {
    setSelectedAccount(acc);
  }

  void setSelectedAccount(Account acc) {
    selectedAccount = acc;
    updateTransactions();
  }

  Future<void> updateTransactions() async {
    final logger = getLogger('AccountDashboardController');
    // logger.e('getting transactions');
    final userId = Get.find<AuthController>().user.uid;
    transactionList = await _transactionRepo.getTransactions(
        userId, selectedAccount.sourceAccountId);
    update();
  }

  Future<void> getLinkedAccounts() async {
    await Get.find<AccountController>().getAllLinkedAccounts();
  }
}
