import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';
import 'package:pispapp/models/transaction.dart';

void main() {
  Map<String, dynamic> json;
  Quote quote;

  setUp(() {
    json = <String, dynamic>{
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
    };

    quote = Quote(
      condition: 'gbj027g5qlzw5v3x5083gtd5n35jqmoqkq0u84seb5v',
      expiration: '1970-01-01T00:00:00.006Z',
      ilpPacket:
          '6pjc9xrf0zgdwkjbia74654wf39qpsz4w8sdqtiqzh0e7q5akkkl7v3wiiiwgzp19nqpgu',
      transferAmount: Money('25', Currency.USD),
      payeeFspFee: Money('5', Currency.USD),
      payeeFspCommission: Money('5', Currency.USD),
    );
  });

  test('fromJson() makes correct object', () {
    final Quote quoteObject = Quote.fromJson(json);
    expect(quote == quoteObject, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromQuote = quote.toJson();
    expect(eq(json, jsonFromQuote), true);
  });
}
