import 'package:equatable/equatable.dart';

import 'model.dart';

class PhoneNumber extends Equatable implements Model {
  PhoneNumber(this.countryCode, this.number);

  final String countryCode;

  final String number;

  @override
  String toString() {
    return countryCode + number;
  }

  @override
  List<Object> get props => [countryCode, number];
}
