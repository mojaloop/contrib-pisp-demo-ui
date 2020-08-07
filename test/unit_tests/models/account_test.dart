import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/fsp_info.dart';
import 'package:pispapp/models/party_id_info.dart';
import 'package:collection/collection.dart';

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
        'fspId': 'DJCICFQ1919',
        'fspName': 'Bank of India',
        'fspIconUrl': 'https://example.com/bankOfIndia',
      }
    };

    account = Account(
      alias: 'Personal',
      consentId: '555',
      sourceAccountId: 'bob.fspB',
      userId: 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
      partyInfo: PartyIdInfo(
        fspId: 'DJCICFQ1919',
        partyIdType: 'MSISDN',
        partyIdentifier: 'IN9999999999',
      ),
      fspInfo: FspInfo(
        fspId: 'DJCICFQ1919',
        fspName: 'Bank of India',
        fspIconUrl: 'https://example.com/bankOfIndia',
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
