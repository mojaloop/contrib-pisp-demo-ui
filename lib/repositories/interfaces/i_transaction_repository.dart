import 'dart:async';

import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';

// Abstraction for methods related to read/write tracsaction information from external data sources
abstract class ITransactionRepository {
  Future<List<Transaction>> getTransactions(
      String userId, String sourceAccountId);
  Future<String> initiateTransaction(
      String userId, String phoneIsoCode, String phoneNumber);
  StreamSubscription setupTransactionStream(String transactionid);
  Future<void> finalizePayment(
      String transactionId, String amount, Account payerAccount);
  Future<void> authorizePayment(String transactionId, String signedString);
}
