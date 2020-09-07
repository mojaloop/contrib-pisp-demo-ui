import 'package:json_annotation/json_annotation.dart';

/// Enumeration of the current supported currencies.
enum Currency {
  @JsonValue('SGD')
  SGD,

  @JsonValue('USD')
  USD,
}