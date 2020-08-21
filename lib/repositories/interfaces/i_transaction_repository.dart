import 'dart:async';

import 'package:pispapp/models/transaction.dart';

// Abstraction for methods related to read/write tracsaction information from external data sources
abstract class ITransactionRepository {
  ///
  ///
  Future<List<Transaction>> getTransactions(String userId);

  ///
  ///
  void Function() listen(String id, {TransactionHandler onValue});

  ///
  ///
  Future<String> add(Map<String, dynamic> data);

  ///
  ///
  Future<void> updateData(String id, Map<String, dynamic> data);

  ///
  ///
  Future<void> setData(String id, Map<String, dynamic> data,
      {bool merge = false});
}

typedef TransactionHandler = void Function(Transaction);
