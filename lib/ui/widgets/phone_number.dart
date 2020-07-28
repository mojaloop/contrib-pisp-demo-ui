import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:pispapp/config/countries.dart';

class PhoneNumberInput extends StatelessWidget {
  PhoneNumberInput(this._onPhoneNumberChange, this.hintText, this.initialPhoneNumber);

  final void Function(String, String, String) _onPhoneNumberChange;
  final String hintText, initialPhoneNumber;

  @override
  Widget build(BuildContext context) => InternationalPhoneInput(
        hintText: hintText,
        onPhoneNumberChange: _onPhoneNumberChange,
        initialPhoneNumber: '',
        initialSelection: '',
        enabledCountries: Countries.countryCodes,
      );
}
