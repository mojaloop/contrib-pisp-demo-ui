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
    final _accounts = await _accountRepository.getUserAccounts(
      Get.find<AuthController>().user?.id,
    );
    accounts.clear();
    accounts.addAll(_accounts);
  }

  void _startListening(String userId) {
    _unsubscriber = _accountRepository.listen(userId, onValue: _onValue);
  }

  void _stopListening() {
    _unsubscriber();
  }

  /// Replaces the entire value of accounts with
  /// whatever firebase listener found
  /// this is only valid for the demo where we _clear_ the list
  /// of accounts, to ensure we always have the most recent
  /// security key
  void _onValue(List<Account> _accounts) {
    logger.w('_onValue called - found ${_accounts.length} accounts');
    accounts.clear();
    accounts.addAll(_accounts);
  }
}
