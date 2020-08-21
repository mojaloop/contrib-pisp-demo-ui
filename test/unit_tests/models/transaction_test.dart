import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
import 'package:pispapp/models/party.dart';
import 'package:pispapp/models/transaction.dart';

void main() {
  Map<String, dynamic> json;
  Transaction transaction;
  setUp(() {
    json = <String, dynamic>{
      'completedTimestamp': '2020-08-04T12:03:57.812Z',
      'consentId': '555',
      'responseType': 'AUTHORIZED',
      'sourceAccountId': 'bob.fspB',
      'status': 'SUCCESS',
      'transactionId': '273a7307-27f8-40eb-a5eb-9a76374c8bee',
      'transactionRequestId': '74987ec0-a5f1-4059-af06-f541dc70c379',
      'userId': 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
      'amount': {
        'amount': '100',
        'currency': 'USD',
      },
      'authentication': {
        'type': 'U2F',
        'value': 'asdAhasdkljassdaASD2131bA',
      },
      'payee': {
        'name': 'John Doe',
        'partyIdInfo': {
          'fspId': 'DJCICFQ1919',
          'partyIdType': 'MSISDN',
          'partyIdentifier': 'IN9999999999',
        },
      },
      'quote': {
        'condition': 'gbj027g5qlzw5v3x5083gtd5n35jqmoqkq0u84seb5v',
        'expiration': '1970-01-01T00:00:00.006Z',
        'ilpPacket':
            '6pjc9xrf0zgdwkjbia74654wf39qpsz4w8sdqtiqzh0e7q5akkkl7v3wiiiwgzp19nqpgu',
        'transferAmount': {
          'amount': '25',
          'currency': 'USD',
        },
        'payeeFspFee': {
          'amount': '5',
          'currency': 'USD',
        },
        'payeeFspCommission': {
          'amount': '5',
          'currency': 'USD',
        }
      }
    };

    transaction = Transaction(
      completedTimestamp: '2020-08-04T12:03:57.812Z',
      consentId: '555',
      responseType: ResponseType.authorized,
      sourceAccountId: 'bob.fspB',
      status: TransactionStatus.success,
      transactionId: '273a7307-27f8-40eb-a5eb-9a76374c8bee',
      transactionRequestId: '74987ec0-a5f1-4059-af06-f541dc70c379',
      userId: 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
      amount: Money('100', Currency.USD),
      authentication: Authentication(
        type: AuthenticationType.u2f,
        value: 'asdAhasdkljassdaASD2131bA',
      ),
      payee: Party(
        name: 'John Doe',
        partyIdInfo: PartyIdInfo(
          fspId: 'DJCICFQ1919',
          partyIdType: 'MSISDN',
          partyIdentifier: 'IN9999999999',
        ),
      ),
      quote: Quote(
        condition: 'gbj027g5qlzw5v3x5083gtd5n35jqmoqkq0u84seb5v',
        expiration: '1970-01-01T00:00:00.006Z',
        ilpPacket:
            '6pjc9xrf0zgdwkjbia74654wf39qpsz4w8sdqtiqzh0e7q5akkkl7v3wiiiwgzp19nqpgu',
        transferAmount: Money('25', Currency.USD),
        payeeFspFee: Money('5', Currency.USD),
        payeeFspCommission: Money('5', Currency.USD),
      ),
    );
  });

  test('fromJson() makes correct object', () {
    final Transaction transactionObject = Transaction.fromJson(json);
    expect(transaction == transactionObject, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromTransaction = transaction.toJson();
    expect(eq(json, jsonFromTransaction), true);
  });
}
