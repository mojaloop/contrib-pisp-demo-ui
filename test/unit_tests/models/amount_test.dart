
import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/amount.dart';
import 'package:collection/collection.dart';

void main() {
  Map<String, dynamic> json;
  Amount amount;
  setUp(() {
    json = <String, dynamic>{
      'amount': '100',
      'currency': 'USD',
    };

    amount = Amount(amount: '100', currency: 'USD');

  });

  test('fromJson() makes correct object', () {
    final Amount amountObject = Amount.fromJson(json);
    expect(amount == amountObject, true);

  });

  test('toJson() makes correct map', () {
    Function eq = const DeepCollectionEquality().equals;
    Map<String, dynamic> jsonFromAmount = amount.toJson();
    expect(eq(json, jsonFromAmount), true);
  });
}