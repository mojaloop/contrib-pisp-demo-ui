import 'dart:collection';
import 'package:pispapp/models/consent.dart';

import 'package:get/get.dart';

class AssociatedAccountsController extends GetxController {
  AssociatedAccountsController(this.associatedAccounts);
  final List<Account> associatedAccounts;
  final HashSet<String> _selectedAccIds = HashSet();

  void onTap(String accId) {
    if (isAccSelected(accId)) {
      _unselectAcc(accId);
    } else {
      _selectAcc(accId);
    }
    update();
  }

  bool isAccSelected(String accId) {
    return _selectedAccIds.contains(accId);
  }

  List<Account> getSelectedAccounts() {
    return associatedAccounts
        .where((account) => _selectedAccIds.contains(account.id))
        .toList();
  }

  List<CredentialScope> getSelectedScopes() {
    return associatedAccounts
        .where((account) => _selectedAccIds.contains(account.id))
        .map((e) =>
            CredentialScope(actions: ['accounts.transfer'], accountId: e.id))
        .toList();
  }

  void _selectAcc(String accId) {
    _selectedAccIds.add(accId);
  }

  void _unselectAcc(String accId) {
    _selectedAccIds.remove(accId);
  }
}
