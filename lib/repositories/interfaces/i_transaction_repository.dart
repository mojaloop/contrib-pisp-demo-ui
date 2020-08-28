import 'dart:async';

import 'package:pispapp/models/transaction.dart';

typedef TransactionHandler = void Function(Transaction);

/// Abstraction for methods related to read/write transaction
/// information from external data sources.
abstract class ITransactionRepository {
  /// Returns the list of transactions that are associated with
  /// a particular user.
  Future<List<Transaction>> getTransactions(String userId);

  /// Listens on the values for a transaction document. Whenever a transaction
  /// document is updated on the server-side, the previded [onValue] function
  /// will be called (if provided) with the updated transaction object being
  /// passed as a parameter.
  void Function() listen(String id, {TransactionHandler onValue});

  /// Adds a new transaction document to the database.
  Future<String> add(Map<String, dynamic> data);

  /// Updates the value of the given fields in a particular transaction document.
  Future<void> updateData(String id, Map<String, dynamic> data);

  /// Sets the value of the given fields in a particular transaction document.
  /// The main difference between [setData] and [updateData] is the flexibility for
  /// set operation to merge the structure. It means that nested fields that are
  /// not specified in the updated [data] will not be removed from the document.
  Future<void> setData(String id, Map<String, dynamic> data,
      {bool merge = false});
}

typedef TransactionHandler = void Function(Transaction);
