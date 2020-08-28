import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:pispapp/config/countries.dart';
import 'package:pispapp/models/phone_number.dart';

class PhoneNumberInput extends StatelessWidget {
  PhoneNumberInput({this.onUpdate, this.hintText, this.initialValue});

  final String hintText;

  final PhoneNumber initialValue;

  final void Function(PhoneNumber) onUpdate;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneInput(
      hintText: hintText,
      enabledCountries: Countries.countryCodes,
      initialPhoneNumber: initialValue?.number,
      initialSelection: initialValue?.countryCode,
      onPhoneNumberChange: (phoneNumber, _, isoCode) {
        if (onUpdate != null) {
          onUpdate(PhoneNumber(isoCode, phoneNumber));
        }
      },
    );
  }
}
