import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class AccountDashboardController extends GetxController {
  AccountDashboardController(this._transactionRepo);
  Account selectedAccount;
  List<Transaction> transactionList = <Transaction>[];

  ITransactionRepository _transactionRepo;

  void refreshAll() {}

  void onAccountTileTap(Account acc) {
    setSelectedAccount(acc);
  }

  void setSelectedAccount(Account acc) {
    selectedAccount = acc;
    updateTransactions();
  }

  void updateTransactions() {
    final logger = getLogger('AccountDashboardController');
    logger.e('getting transactions');
    transactionList = _transactionRepo.getTransactions(selectedAccount.accountNumber);
    update();
  }

  void refreshAccounts() {
    Get.find<AccountController>().getAllLinkedAccounts();
    // TODO(MahidharBandaru): Handle empty case;
  }
}
