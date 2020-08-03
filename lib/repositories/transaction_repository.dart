import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_details_controller.dart';
import 'package:pispapp/models/account.dart';

class TransactionRepository {
  final Firestore firestore = Firestore.instance;
  CollectionReference get transactions => firestore.collection('transactions');
  StreamSubscription<DocumentSnapshot> _transactionStreamSubscription;

  Future<String> initiatePayment(
      String phoneIsoCode, String phoneNumber) async {
    final documentReference = await transactions.add(
      <String, dynamic>{
        'userId': Get.find<AuthController>().user.uid,
        'payee': {
          'partyIdInfo': {
            'partyIdType': 'MSISDN',
            'partyIdentifier': phoneIsoCode+phoneNumber,
          }
        }
      },
    );
    setupTransactionStream(documentReference.documentID);
    return documentReference.documentID;
  }

  void setupTransactionStream(String transactionid) {
    _transactionStreamSubscription = transactions.document(transactionid).snapshots().listen((snapshot) {
      if(snapshot.data != null) {
        switch (snapshot.data['status'] as String) {
          case 'PENDING_PARTY_LOOKUP': {
            // Maybe timeout after 10 seconds ? 
          }
          break;
          case 'PENDING_PAYEE_CONFIRMATION': {
            final String name = snapshot.data['payee']['name'] as String;
            Get.find<LookupPayeeController>().foundPayee(name);
          }
          break;
          case 'AUTHORIZATION_REQUIRED': {
            int transactionFees;
            if(snapshot.data['quote']['payeeFspFee'] != null) {
              transactionFees = int.parse(snapshot.data['quote']['payeeFspFee']['amount'] as String);
            }
            else {
              transactionFees = 0;
            }
            Get.find<PaymentDetailsController>().getAuthorization(transactionFees.toString());
          }
          break;
          case 'SUCCESS': {
            Get.find<PaymentDetailsController>().onSuccess();
          }
          break;
          default: {
            // throw Exception();
          }
        }

      }
    });
  }

  Future<void> finalizePayment(String transactionId, String amount, Account payerAccount) async {
    await transactions.document(transactionId).updateData(
      <String, dynamic>{
        'sourceAccountId': 'bob.fspb',
        'consentId': '555',
        'amount': {
          'amount': amount,
          'currency': 'USD',
        },
        'payer': payerAccount.name,
      },
    );
  }

  Future<void> authorizePayment(String transactionId, String signedString) async{
    await transactions.document(transactionId).updateData(
      <String, dynamic>{
        'authentication': {
          'value': signedString,
        },
        'responseType': 'AUTHORIZED',
      },
    );
  }
}
