import 'package:get/get.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';
import 'package:pispapp/routes/custom_navigator.dart';

class LookupPayeeController extends GetxController {
  LookupPayeeController(this._transactionRepository);

  List<Account> payeeAccounts = <Account>[];
  // ignore: unused_field
  ITransactionRepository _transactionRepository;
  bool isLoading = true;
  String payeeName;

  @override
  void onInit() {
    if (Config.TRANSACTION_STUB == true) {
      foundPayee(Config.STUB_PAYEE_NAME);
    }
    super.onInit();
    update();
  }

  void foundPayee(String name) {
    payeeName = name;
    isLoading = false;
    update();
  }

  void onTapPayertile() {
    Get.find<CustomNavigator>().toNamed('/transfer/finalize');
  }
}
