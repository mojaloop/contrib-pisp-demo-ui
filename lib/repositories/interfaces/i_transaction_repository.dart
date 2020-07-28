import 'package:pispapp/models/transaction.dart';

abstract class ITransactionRepository {
  List<Transaction> getTransactions(String accountId);
}
