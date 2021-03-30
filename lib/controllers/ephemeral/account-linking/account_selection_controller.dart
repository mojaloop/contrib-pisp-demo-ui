import 'dart:collection';
import 'package:pispapp/models/consent.dart';

import 'package:get/get.dart';

class AccountSelectionController extends GetxController {
  AccountSelectionController(
      this.associatedAccounts, this.onSelectedAccountsChanged);

  final List<Account> associatedAccounts;
  final HashSet<Account> _selectedAccounts = HashSet();
  Function onSelectedAccountsChanged;

  void onTap(Account acc) {
    if (isAccSelected(acc)) {
      _unselectAcc(acc);
    } else {
      _selectAcc(acc);
    }
    update();
  }

  bool isAccSelected(Account acc) {
    return _selectedAccounts.contains(acc);
  }

  List<Account> getSelectedAccounts() {
    return associatedAccounts
        .where((account) => _selectedAccounts.contains(account))
        .toList();
  }

  List<CredentialScope> getSelectedScopes() {
    return associatedAccounts
        .where((account) => _selectedAccounts.contains(account))
        .map((e) =>
            CredentialScope(actions: ['accounts.transfer'], accountId: e.id))
        .toList();
  }

  void _selectAcc(Account acc) {
    _selectedAccounts.add(acc);
    onSelectedAccountsChanged(_selectedAccounts);
  }

  void _unselectAcc(Account acc) {
    _selectedAccounts.remove(acc);
    onSelectedAccountsChanged(_selectedAccounts);
  }
}
