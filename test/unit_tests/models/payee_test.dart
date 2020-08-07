import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/party_id_info.dart';
import 'package:pispapp/models/payee.dart';
import 'package:collection/collection.dart';

void main() {
  Map<String, dynamic> json;
  Payee payee;
  setUp(() {
    json = <String, dynamic>{
      'name': 'John Doe',
      'partyIdInfo': {
        'fspId': 'DJCICFQ1919',
        'partyIdType': 'MSISDN',
        'partyIdentifier': 'IN9999999999',
      },
    };

    payee = Payee(
      name: 'John Doe',
      partyIdInfo: PartyIdInfo(
        fspId: 'DJCICFQ1919',
        partyIdType: 'MSISDN',
        partyIdentifier: 'IN9999999999',
      ),
    );
  });

  test('fromJson() makes correct object', () {
    final Payee payeeObject = Payee.fromJson(json);
    expect(payee == payeeObject, true);
  });

  test('toJson() makes correct map', () {
    Function eq = const DeepCollectionEquality().equals;
    Map<String, dynamic> jsonFromPayee = payee.toJson();
    expect(eq(json, jsonFromPayee), true);
  });
}
