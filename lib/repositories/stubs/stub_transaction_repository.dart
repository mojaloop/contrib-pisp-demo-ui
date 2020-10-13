import 'dart:async';

import 'package:pispapp/models/party.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/models/currency.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

List<Transaction> _stubTransactionData = <Transaction>[
  Transaction(
    amount: Money('100', Currency.USD),
    completedTimestamp: '2020-08-04T02:38:56.779Z',
    payee: Party(
      name: 'Mark Doe',
      partyIdInfo: PartyIdInfo(partyIdentifier: 'IN1233323987'),
    ),
    status: TransactionStatus.success,
    sourceAccountId: 'bob.fspA',
  ),
  Transaction(
    amount: Money('100', Currency.USD),
    completedTimestamp: '2020-08-04T02:38:56.779Z',
    payee: Party(
      name: 'John Doe',
      partyIdInfo: PartyIdInfo(partyIdentifier: 'IN9876564738'),
    ),
    status: TransactionStatus.success,
    sourceAccountId: 'bob.fspA',
  ),
  Transaction(
    amount: Money('100', Currency.USD),
    completedTimestamp: '2020-08-04T02:38:56.779Z',
    payee: Party(
      name: 'Lily Doe',
      partyIdInfo: PartyIdInfo(partyIdentifier: 'IN1238748576'),
    ),
    status: TransactionStatus.success,
    sourceAccountId: 'bob.fspA',
  ),
  Transaction(
    amount: Money('100', Currency.USD),
    completedTimestamp: '2020-08-04T02:38:56.779Z',
    payee: Party(
      name: 'Mark Doe',
      partyIdInfo: PartyIdInfo(partyIdentifier: 'IN1233323987'),
    ),
    status: TransactionStatus.success,
    sourceAccountId: 'bob.fspB',
  ),
];

class StubTransactionRepository implements ITransactionRepository {
  @override
  Future<List<Transaction>> getTransactions(String userId) async {
    return Future<List<Transaction>>.value(_stubTransactionData.toList());
  }

  @override
  // ignore: missing_return
  void Function() listen(String id, {TransactionHandler onValue}) {}

  @override
  // ignore: missing_return
  Future<String> add(Map<String, dynamic> data) {}

  @override
  // ignore: missing_return
  Future<void> updateData(String id, Map<String, dynamic> data) {}

  @override
  // ignore: missing_return
  Future<void> setData(String id, Map<String, dynamic> data,
      {bool merge = false}) {}
}
