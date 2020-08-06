import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_details_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_verdict_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart' as transaction_model;

import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  final Firestore firestore = Firestore.instance;
  CollectionReference get transactions => firestore.collection('transactions');

  @override
  Future<List<transaction_model.Transaction>> getTransactions(
      String userId, String sourceAccountId) async {
    final userTransactions = await transactions
        .where('userId', isEqualTo: userId)
        .where('sourceAccountId', isEqualTo: sourceAccountId)
        .getDocuments();
    final List<transaction_model.Transaction> transactionList = userTransactions
        .documents
        .map((DocumentSnapshot element) =>
            transaction_model.Transaction.fromJson(element.data))
        .toList();
    return transactionList;
  }

  @override
  Future<String> initiateTransaction(
      String userId, String phoneIsoCode, String phoneNumber) async {
    final documentReference = await transactions.add(
      <String, dynamic>{
        'userId': userId,
        'payee': {
          'partyIdInfo': {
            'partyIdType': 'MSISDN',
            'partyIdentifier': phoneIsoCode + phoneNumber,
          }
        }
      },
    );
    return documentReference.documentID;
  }

  @override
  StreamSubscription<DocumentSnapshot> setupTransactionStream(
      String transactionid) {
    final transactionStreamSubscription =
        transactions.document(transactionid).snapshots().listen(
      (snapshot) {
        if (snapshot.data != null) {
          final transaction_model.Transaction transaction =
              transaction_model.Transaction.fromJson(snapshot.data);
          switch (transaction.status) {
            case 'PENDING_PARTY_LOOKUP':
              {
                // Maybe timeout after 10 seconds ?
              }
              break;
            case 'PENDING_PAYEE_CONFIRMATION':
              {
                final String name = transaction.payee.name;

                // Notify lookup payee controller that the payee is found
                Get.find<LookupPayeeController>().foundPayee(name);
              }
              break;
            case 'AUTHORIZATION_REQUIRED':
              {
                // Already authorized case
                if (transaction.responseType == 'ENTERED') {
                  return;
                }
                int transactionFees;
                if (transaction.quote.payeeFspFee != null) {
                  transactionFees =
                      int.parse(transaction.quote.payeeFspFee.amount);
                } else {
                  // TODO(StevenWjy): Some dummy value for now. Needs to be changed to zero.
                  transactionFees = 5;
                }

                // Ask payment details controller to get authorization from user
                Get.find<PaymentDetailsController>()
                    .onQuoteAvailable(transactionFees.toString());
              }
              break;
            case 'SUCCESS':
              {
                Get.find<PaymentVerdictController>().onSuccess();
              }
              break;
            default:
              {
                // throw Exception();
              }
          }
        }
      },
    );
    return transactionStreamSubscription;
  }

  @override
  Future<void> finalizePayment(
      String transactionId, String amount, Account payerAccount) async {
    await transactions.document(transactionId).setData(
      <String, dynamic>{
        'sourceAccountId': payerAccount.sourceAccountId,
        'consentId': '555',
        'amount': {
          'amount': amount,
          'currency': 'USD',
        },
      },
      merge: true,
    );
  }

  @override
  Future<void> authorizePayment(
      String transactionId, String signedString) async {
    await transactions.document(transactionId).setData(
      <String, dynamic>{
        'authentication': {
          'value': signedString,
        },
        'responseType': 'AUTHORIZED',
      },
      merge: true,
    );
  }
}
