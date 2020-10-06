import 'dart:collection';
import 'package:pispapp/models/consent.dart';

import 'package:get/get.dart';

class AccountSelectionController extends GetxController {
  AccountSelectionController(this.associatedAccounts);
  final List<Account> associatedAccounts;
  final HashSet<Account> _selectedAccounts = HashSet();

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

  void _selectAcc(Account acc) {
    _selectedAccounts.add(acc);
  }

  void _unselectAcc(Account acc) {
    _selectedAccounts.remove(acc);
  }
}
