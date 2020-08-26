import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:collection/collection.dart';

void main() {
  Map<String, dynamic> json;
  Money money;

  setUp(() {
    json = <String, dynamic>{
      'amount': '100',
      'currency': 'USD',
    };

    money = Money('100', Currency.USD);
  });

  test('fromJson() makes correct object', () {
    final Money moneyObject = Money.fromJson(json);
    expect(money == moneyObject, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromAmount = money.toJson();
    expect(eq(json, jsonFromAmount), true);
  });
}
