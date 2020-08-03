import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';
import 'package:pispapp/repositories/transaction_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class LookupPayeeController extends GetxController {
  LookupPayeeController(this._transactionRepository);

  List<Account> payeeAccounts = <Account>[];
  TransactionRepository _transactionRepository;
  bool isLoading = true;
  String payeeName;

  @override
  void onInit() {
    
    // payeeAccounts = _accountRepository.getPayeeAccountsByPhone(phoneNumber);
    super.onInit();
    update();
  }

  void foundPayee(String name) {
    payeeName = name;
    isLoading = false;
    update();
  }

  void onTapPayertile() {
    Get.toNamed<dynamic>('/transfer/finalize');
  }
}
