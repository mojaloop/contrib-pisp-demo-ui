import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

class AccountDashboardController extends GetxController {
  AccountDashboardController(this._transactionRepo);

  Account selectedAccount;

  List<Account> accountList = <Account>[];
  List<Transaction> transactionList = <Transaction>[];

  bool isLoading = false;

  ITransactionRepository _transactionRepo;

  // @override
  // Future<void> onReady() async {
  //   print('AccountDashboardController - Refreshing!');
  //   isLoading = true;

  //   // LD - TODO - calling this seems to crash the application
  //   // update();

  //   await getLinkedAccounts();
  //   accountList = Get.find<AccountController>().accounts;
  //   if (accountList.isNotEmpty) {
  //     await setSelectedAccount(accountList.first);
  //   }

  //   // if (Get.find<AccountController>().accounts.isEmpty) {
  //   //   noAccounts = true;
  //   // } else {
  //   //   noAccounts = false;
  //   //   await setSelectedAccount(
  //   //     Get.find<AccountController>().accounts.elementAt(0),
  //   //   );
  //   // }

  //   isLoading = false;

  //   print('AccountDashboardController - done!');

  //   // LD - TODO - calling this seems to crash the application
  //   // update();
  // }

  Future<void> setSelectedAccount(Account acc) async {
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
}
