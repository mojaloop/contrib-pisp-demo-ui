import 'dart:async';
import 'package:get/get.dart';

import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/party.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_transaction_repository.dart';
import 'package:pispapp/ui/pages/payment/payment_authorization.dart';
import 'package:pispapp/ui/pages/payment/payment_confirmation.dart';
import 'package:pispapp/ui/pages/payment/payment_result.dart';
import 'package:pispapp/utils/local_auth.dart';

class PaymentFlowController extends GetxController {
  PaymentFlowController(this._transactionRepository);

  ITransactionRepository _transactionRepository;

  bool isAwaitingUpdate = false;

  Transaction transaction;
  String documentId;

  void Function() _unsubscriber;

  /// Initiates a transaction to the given phone number.
  Future<void> initiate(PhoneNumber phoneNumber) async {
    _setAwaitingUpdate();

    final user = Get.find<AuthController>().user;
    documentId = await _transactionRepository.add(<String, dynamic>{
      'userId': user.id,
      'payee': {
        'partyIdInfo': {
          'partyIdType': PartyIdType.msisdn.toJsonString(),
          'partyIdentifier': phoneNumber.toString(),
        }
      }
    });

    _startListening(documentId);
  }

  /// Confirms the payee of a proposed financial transaction and keys in necessary
  /// data to move forward with the transfer.
  Future<void> confirm(Money amount, Account account) async {
    _setAwaitingUpdate();

    await _transactionRepository.updateData(transaction.id, <String, dynamic>{
      'sourceAccountId': account.sourceAccountId,
      'consentId': account.consentId,
      'amount': {
        'amount': amount.amount,
        'currency': amount.currency.toJsonString(),
      },
    });
  }

  /// Authorizes the transaction that is currently managed by the controller. The status
  /// of the transaction must be equal to [TransactionStatus.authorizationRequired]
  /// upon calling this function.
  Future<void> authorize() async {
    _setAwaitingUpdate();

    // Ask user to provide their authentication. For example, the app could prompt
    // user to give their fingerprint.
    final isUserAuthenticated = await LocalAuth.authenticateUser(
      'Please authorize to continue the transaction.',
    );

    if (isUserAuthenticated) {
      // TODO(kkzeng): Implement the signing here
      const String signature = 'unimplemented123';

      // Update Firebase with the authentication value, which in this case
      // is the signature.
      _transactionRepository.setData(
        transaction.id,
        <String, dynamic>{
          'authentication': {
            'value': signature,
          },
          'responseType': ResponseType.authorized.toJsonString(),
        },
        merge: true,
      );
    } else {
      // TODO(kkzeng): What happens when the authentication fails?
    }
  }

  void _startListening(String id) {
    _unsubscriber = _transactionRepository.listen(id, onValue: _onValue);
  }

  void _stopListening() {
    _unsubscriber();
  }

  void _setAwaitingUpdate() {
    // Update the payment status to be waiting for further update.
    // This is intended to inform the UI that the user is not expected to
    // make any action and just need to wait. For example, a circular progress
    // indicator could be displayed.
    isAwaitingUpdate = true;
    update();
  }

  void _onValue(Transaction transaction) {
    // Put the document id in the model object
    transaction.id = documentId;

    final oldValue = this.transaction;
    this.transaction = transaction;

    switch (transaction.status) {
      case TransactionStatus.pendingPartyLookup:
        // Do nothing here as we just need to wait for the server
        // to request a party lookup in Mojaloop.
        break;

      case TransactionStatus.pendingPayeeConfirmation:
        // The server has finished performing a party lookup and now it is
        // the time for us to ask the user whether the party information
        // (e.g., name) is correct. If yes, the user needs to key in some
        // other values (e.g, transaction amount) to continue the process.
        if (oldValue.status == TransactionStatus.pendingPartyLookup) {
          // The transaction data has been updated
          isAwaitingUpdate = false;
          update();

          Get.to<dynamic>(PaymentConfirmation(this));
        }
        break;

      case TransactionStatus.authorizationRequired:
        // The user must provide its authorization to continue the transaction.
        // Here, the app has received the quote of the transaction from the server.
        // The user will be able to get information about the fee and commission
        // that are imposed by the FSPs and also more details about the transfer amount.
        if (oldValue.status == TransactionStatus.pendingPayeeConfirmation) {
          // The transaction data has been updated
          isAwaitingUpdate = false;
          update();

          Get.to<dynamic>(PaymentAuthorization(this));
        }
        break;

      case TransactionStatus.success:
        // The transaction has been marked as successful on the server-side.
        if (oldValue.status == TransactionStatus.authorizationRequired) {
          // The transaction data has been updated
          isAwaitingUpdate = false;
          update();

          Get.to<dynamic>(PaymentResult(this));

          // Stop listening for the updates of the transaction.
          _stopListening();
        }
        break;
    }
  }
}
