import 'package:json_annotation/json_annotation.dart';

/// Enumeration of the current supported currencies.
enum Currency {
  @JsonValue('SGD')
  SGD,

  @JsonValue('USD')
  USD,
}

// Not auto-generated, must be updated in line with the values
// above.
extension CurrencyJson on Currency {
  String toJsonString() {
    String jsonStr;
    switch (this) {
      case Currency.SGD:
        jsonStr = 'SGD';
        break;
      case Currency.USD:
        jsonStr = 'USD';
        break;
    }
    return jsonStr;
  }
}
