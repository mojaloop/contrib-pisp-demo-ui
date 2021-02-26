import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

class AccountDashboardController extends GetxController {
  AccountDashboardController(this._transactionRepo);

  Account selectedAccount;

  List<Transaction> transactionList = <Transaction>[];

  bool isLoading = true;

  ITransactionRepository _transactionRepo;

  bool noAccounts = true;

  @override
  Future<void> refresh() async {
    // isLoading = true;
    // update();

    // await getLinkedAccounts();

    // if (Get.find<AccountController>().accounts.isEmpty) {
    //   noAccounts = true;
    // } else {
    //   noAccounts = false;
    //   await setSelectedAccount(
    //     Get.find<AccountController>().accounts.elementAt(0),
    //   );
    // }
    // isLoading = false;

    // update();
  }

  Future<void> setSelectedAccount(Account acc) async {
    selectedAccount = acc;
    await updateTransactions();
  }

  Future<void> updateTransactions() async {
    final userId = Get.find<AuthController>().user.id;
    transactionList = await _transactionRepo.getTransactions(userId);
    update();
  }

  Future<void> getLinkedAccounts() async {
    await Get.find<AccountController>().getLinkedAccounts();
  }
}
