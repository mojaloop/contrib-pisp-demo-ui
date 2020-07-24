import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

List<Transaction> transactions = <Transaction>[
  Transaction(
    '120980988878828',
    '123123123',
    '100',
    '23 Feb 2020',
    'Mark Doe',
    Status.SUCCESSFUL,
  ),
  Transaction(
    '120980988878828',
    '123123123',
    '100',
    '23 Feb 2020',
    'Mark Doe',
    Status.PENDING,
  ),
  Transaction(
    '120980988878828',
    '123123123',
    '100',
    '15 Feb 2020',
    'Mark Doe',
    Status.ERROR,
  ),
  Transaction(
    '1231231',
    '120980988878828',
    '100',
    '10 Feb 2020',
    'John',
    Status.ERROR,
  ),
  Transaction(
    '120980988878821',
    '123123123',
    '100',
    '8 Feb 2020',
    'Mark Doe',
    Status.SUCCESSFUL,
  ),
  Transaction(
    '1231231',
    '120980988878821',
    '100',
    '2 Feb 2020',
    'John',
    Status.PENDING,
  ),
];


List<Transaction> getMockTransactions(String accountId) {
  return transactions
      .where((Transaction element) => element.from == accountId)
      .toList();
}

class MockTransactionRepository extends ITransactionRepository {
  @override
  List<Transaction> getTransactions(String accountId) {
    var ans = getMockTransactions(accountId);
    return ans;
  }
}
