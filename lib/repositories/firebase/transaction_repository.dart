import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' show Firestore;

import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  final _colRef = Firestore.instance.collection('transactions');

  @override
  Future<List<Transaction>> getTransactions(String userId) async {
    return _colRef.where('userId', isEqualTo: userId).getDocuments().then(
          (snapshot) => snapshot.documents
              .map((element) => Transaction.fromJson(element.data))
              .toList(),
        );
  }

  @override
  void Function() listen(String id, {TransactionHandler onValue}) {
    final subscription = _colRef.document(id).snapshots().listen((event) {
      final transaction = Transaction.fromJson(event.data);
      if (onValue != null) {
        onValue(transaction);
      }
    });

    return () => subscription.cancel();
  }

  @override
  Future<String> add(Map<String, dynamic> data) async {
    final docRef = await _colRef.add(data);
    return docRef.documentID;
  }

  @override
  Future<void> updateData(String id, Map<String, dynamic> data) async {
    await _colRef.document(id).updateData(data);
  }

  @override
  Future<void> setData(String id, Map<String, dynamic> data,
      {bool merge = false}) async {
    await _colRef.document(id).setData(data, merge: merge);
  }
}
