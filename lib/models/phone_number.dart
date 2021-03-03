import 'package:equatable/equatable.dart';

import 'model.dart';

class PISPPhoneNumber extends Equatable implements Model {
  PISPPhoneNumber(this.countryCode, this.number);

  final String countryCode;

  final String number;

  @override
  String toString() {
    return countryCode + number;
  }

  @override
  List<Object> get props => [countryCode, number];
}
