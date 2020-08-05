import 'dart:async';

import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_details_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_verdict_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/amount.dart';
import 'package:pispapp/models/party_id_info.dart';
import 'package:pispapp/models/payee.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

List<Transaction> transactions = <Transaction>[
  Transaction(
    amount: Amount(
      amount: '100',
      currency: 'USD',
    ),
    completedTimestamp: '23 Feb 2020',
    payee: Payee(
      name: 'Mark Doe',
      partyIdInfo: PartyIdInfo(partyIdentifier: 'IN1233323987'),
    ),
    status: 'SUCCESS',
    sourceAccountId: 'bob.fspA',
  ),
  Transaction(
    amount: Amount(
      amount: '100',
      currency: 'USD',
    ),
    completedTimestamp: '22 Feb 2020',
    payee: Payee(
      name: 'John Doe',
      partyIdInfo: PartyIdInfo(partyIdentifier: 'IN9876564738'),
    ),
    status: 'PENDING',
    sourceAccountId: 'bob.fspA',
  ),
  Transaction(
    amount: Amount(
      amount: '100',
      currency: 'USD',
    ),
    completedTimestamp: '21 Feb 2020',
    payee: Payee(
      name: 'Lily Doe',
      partyIdInfo: PartyIdInfo(partyIdentifier: 'IN1238748576'),
    ),
    status: 'ERROR',
    sourceAccountId: 'bob.fspA',
  ),
  Transaction(
    amount: Amount(
      amount: '100',
      currency: 'USD',
    ),
    completedTimestamp: '23 Feb 2020',
    payee: Payee(
      name: 'Mark Doe',
      partyIdInfo: PartyIdInfo(partyIdentifier: 'IN1233323987'),
    ),
    status: 'SUCCESS',
    sourceAccountId: 'bob.fspB',
  ),
];

class StubTransactionRepository implements ITransactionRepository {
  @override
  Future<List<Transaction>> getTransactions(
      String userId, String accountId) async {
    return Future<List<Transaction>>.value(transactions
        .where((Transaction element) => element.sourceAccountId == accountId)
        .toList());
  }

  @override
  Future<String> initiateTransaction(
      String userId, String phoneIsoCode, String phoneNumber) {
    const String val = 'asdAhasdkljassdaASD2131bA';
    return Future<String>.value(val);
  }

  @override
  // ignore: missing_return
  StreamSubscription setupTransactionStream(String transactionid) {}

  @override
  // ignore: missing_return
  Future<void> finalizePayment(
      String transactionId, String amount, Account payerAccount) {}

  @override
  // ignore: missing_return
  Future<void> authorizePayment(String transactionId, String signedString) {}
}
