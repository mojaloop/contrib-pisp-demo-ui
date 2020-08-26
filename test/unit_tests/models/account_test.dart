import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/party.dart';
import 'package:pispapp/models/fsp.dart';

void main() {
  Map<String, dynamic> json;

  Account account;

  setUp(() {
    json = <String, dynamic>{
      'alias': 'Personal',
      'consentId': '555',
      'sourceAccountId': 'bob.fspB',
      'userId': 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
      'partyInfo': {
        'fspId': 'DJCICFQ1919',
        'partyIdType': 'MSISDN',
        'partyIdentifier': 'IN9999999999',
      },
      'fspInfo': {
        'id': 'DJCICFQ1919',
        'name': 'Bank of India',
      }
    };

    account = Account(
      alias: 'Personal',
      consentId: '555',
      sourceAccountId: 'bob.fspB',
      userId: 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
      partyInfo: PartyIdInfo(
        fspId: 'DJCICFQ1919',
        partyIdType: PartyIdType.msisdn,
        partyIdentifier: 'IN9999999999',
      ),
      fspInfo: Fsp(
        id: 'DJCICFQ1919',
        name: 'Bank of India',
      ),
    );
  });

  test('fromJson() makes correct object', () {
    final Account accountObject = Account.fromJson(json);
    expect(account == accountObject, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromAccount = account.toJson();

    expect(eq(json, jsonFromAccount), true);
  });
}
