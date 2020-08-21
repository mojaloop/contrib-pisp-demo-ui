import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/party.dart';
import 'package:collection/collection.dart';

void main() {
  Map<String, dynamic> json;
  Party party;

  setUp(() {
    json = <String, dynamic>{
      'name': 'John Doe',
      'partyIdInfo': {
        'fspId': 'DJCICFQ1919',
        'partyIdType': 'MSISDN',
        'partyIdentifier': 'IN9999999999',
      },
    };

    party = Party(
      name: 'John Doe',
      partyIdInfo: PartyIdInfo(
        fspId: 'DJCICFQ1919',
        partyIdType: 'MSISDN',
        partyIdentifier: 'IN9999999999',
      ),
    );
  });

  test('fromJson() makes correct object', () {
    final Party partyObject = Party.fromJson(json);
    expect(party == partyObject, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromPayee = party.toJson();
    expect(eq(json, jsonFromPayee), true);
  });
}
