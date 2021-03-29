import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class AccountDashboardController extends GetxController {
  AccountDashboardController(this._transactionRepo);
  final logger = getLogger((AccountDashboardController).toString());

  Account selectedAccount;

  RxList<Account> watchAccounts = Get.find<AccountController>().accounts;
  List<Transaction> transactionList = <Transaction>[];

  bool isLoading = false;

  ITransactionRepository _transactionRepo;

  @override
  Future<void> onReady() async {
    ever(watchAccounts, onAccountsUpdated);

    isLoading = true;
    await getLinkedAccounts();
    isLoading = false;
  }

  Future<void> setSelectedAccount(Account acc) async {
    logger.w('setSelectedAccount: ${acc.alias}');
    selectedAccount = acc;
    await updateTransactions();
  }

  Future<void> updateTransactions() async {
    final userId = Get.find<AuthController>().user?.id;
    transactionList = await _transactionRepo.getTransactions(userId);
    update();
  }

  Future<void> getLinkedAccounts() async {
    await Get.find<AccountController>().getLinkedAccounts();
  }

  Future<void> onAccountsUpdated(List<Account> _accounts) async {
    logger.w('onAccountsUpdated, with ${_accounts.length} accounts');

    if (_accounts.isNotEmpty) {
      await setSelectedAccount(_accounts.first);
    }
  }
}
