import 'package:pispapp/models/transaction.dart';

// Abstraction for methods related to read/write tracsaction information from external data sources
abstract class ITransactionRepository {
  List<Transaction> getTransactions(String accountId);
}
