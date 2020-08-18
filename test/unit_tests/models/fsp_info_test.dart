import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/fsp_info.dart';
import 'package:collection/collection.dart';

void main() {
  Map<String, dynamic> json;
  FspInfo fspInfo;
  setUp(() {
    json = <String, dynamic>{
      'fspId': 'DJCICFQ1919',
      'fspName': 'Bank of India',
      'fspIconUrl': 'https://example.com/bankOfIndia',
    };

    fspInfo = FspInfo(
        fspId: 'DJCICFQ1919',
        fspName: 'Bank of India',
        fspIconUrl: 'https://example.com/bankOfIndia');
  });

  test('fromJson() makes correct object', () {
    final FspInfo fspInfoObject = FspInfo.fromJson(json);
    expect(fspInfo == fspInfoObject, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromFspInfo = fspInfo.toJson();
    expect(eq(json, jsonFromFspInfo), true);
  });
}
