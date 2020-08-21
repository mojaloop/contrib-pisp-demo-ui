import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
import 'package:pispapp/models/fsp.dart';

void main() {
  Map<String, dynamic> json;
  Fsp fsp;

  setUp(() {
    json = <String, dynamic>{
      'id': 'DJCICFQ1919',
      'name': 'Bank of India',
    };

    fsp = Fsp(id: 'DJCICFQ1919', name: 'Bank of India');
  });

  test('fromJson() makes correct object', () {
    final Fsp fspObject = Fsp.fromJson(json);
    expect(fsp == fspObject, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromFspInfo = fsp.toJson();
    expect(eq(json, jsonFromFspInfo), true);
  });
}
