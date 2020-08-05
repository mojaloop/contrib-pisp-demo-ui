import 'package:get/get.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

class AccountController extends GetxController {
  AccountController(this._accountRepository);
  var accounts = <Account>[].obs;

  IAccountRepository _accountRepository;

  void getAllLinkedAccounts() {
    accounts.value = _accountRepository.getUserAccounts();
  }
}
