import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

class LookupPayeeController extends GetxController {
  LookupPayeeController(this._accountRepository);

  List<Account> payeeAccounts;
  IAccountRepository _accountRepository;
  Account payeeAccount;

  @override
  void onInit() {
    final String phoneNumber =
        Get.find<PaymentInitiateController>().phoneIsoCode +
            Get.find<PaymentInitiateController>().phoneNumber;
    payeeAccounts = _accountRepository.getPayeeAccountsByPhone(phoneNumber);
    super.onInit();
    update();
  }

  void onTapPayertile(Account account) {
    payeeAccount = account;
    Get.toNamed<dynamic>('/transfer/finalize');
  }
}
