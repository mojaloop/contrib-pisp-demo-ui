import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class AccountController extends GetxController {
  AccountController(this._accountRepository);

  static final logger = getLogger('AccountController');

  var accounts = <Account>[].obs;

  IAccountRepository _accountRepository;

  void Function() _unsubscriber;

  @override
  void onReady() {
    _startListening(Get.find<AuthController>().user?.id);

    super.onReady();
  }

  @override
  void onClose() {
    _stopListening();
    super.onClose();
  }

  Future<void> getLinkedAccounts() async {
    accounts.value = await _accountRepository.getUserAccounts(
      Get.find<AuthController>().user?.id,
    );
  }

  void _startListening(String userId) {
    _unsubscriber = _accountRepository.listen(userId, onValue: _onValue);
  }

  void _stopListening() {
    _unsubscriber();
  }

  void _onValue(List<Account> accounts) {
    logger.w('_onValue called');
  }
}
