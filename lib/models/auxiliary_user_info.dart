import 'package:equatable/equatable.dart';
import 'package:pispapp/models/phone_number.dart';

import 'model.dart';

// ignore: must_be_immutable
class AuxiliaryUserInfo extends Equatable implements Model {
  AuxiliaryUserInfo({this.registrationDate, this.phoneNumber});

  String registrationDate;
  PhoneNumber phoneNumber;

  @override
  List<Object> get props => [registrationDate, phoneNumber];

  String getFormattedPhoneNoForDisplay() {
    if(phoneNumber == null || (phoneNumber.countryCode == null && phoneNumber.number == null)) {
      return 'n/a';
    }
    return (phoneNumber.countryCode ?? '') + (phoneNumber.number ?? '');
  }

  String getFormattedRegistrationDateForDisplay() {
    return registrationDate == null ? 'n/a' : registrationDate.split('T')[0];
  }
}
