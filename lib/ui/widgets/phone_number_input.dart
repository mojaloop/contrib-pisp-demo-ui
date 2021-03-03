import 'package:flutter/material.dart';
// import 'package:international_phone_input/international_phone_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/config/countries.dart';
// import 'package:pispapp/models/phone_number.dart';

class PhoneNumberInput extends StatelessWidget {
  PhoneNumberInput({this.onUpdate, this.hintText, this.initialValue});

  final String hintText;

  final PISPPhoneNumber initialValue;

  final void Function(PISPPhoneNumber) onUpdate;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
        hintText: hintText,
        onInputChanged: (PhoneNumber number) {
          print(number.phoneNumber);
          if (onUpdate != null) {
            onUpdate(PISPPhoneNumber(number.isoCode, number.phoneNumber));
          }
        },
        onInputValidated: (bool value) {
          print(value);
        },
        // TODO: figure out optional syntax
        initialValue: PhoneNumber(
            phoneNumber: initialValue?.number,
            isoCode: initialValue?.countryCode),
        countries: Countries.countryCodes);
    // return InternationalPhoneInput(
    //   hintText: hintText,
    //   enabledCountries: Countries.countryCodes,
    //   initialPhoneNumber: initialValue?.number,
    //   initialSelection: initialValue?.countryCode,
    //   onPhoneNumberChange: (phoneNumber, _, isoCode) {
    //     if (onUpdate != null) {
    //       onUpdate(PhoneNumber(isoCode, phoneNumber));
    //     }
    //   },
    // );
  }
}
