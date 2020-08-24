import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/party.dart';
import 'package:collection/collection.dart';

void main() {
  Map<String, dynamic> json;
  PartyIdInfo partyIdInfo;
  setUp(() {
    json = <String, dynamic>{
      'fspId': 'DJCICFQ1919',
      'partyIdType': 'MSISDN',
      'partyIdentifier': 'IN9999999999',
    };

    partyIdInfo = PartyIdInfo(
      fspId: 'DJCICFQ1919',
      partyIdType: PartyIdType.msisdn,
      partyIdentifier: 'IN9999999999',
    );
  });

  test('fromJson() makes correct object', () {
    final PartyIdInfo partyIdInfoObject = PartyIdInfo.fromJson(json);
    expect(partyIdInfo == partyIdInfoObject, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromFspInfo = partyIdInfo.toJson();
    expect(eq(json, jsonFromFspInfo), true);
  });
}
