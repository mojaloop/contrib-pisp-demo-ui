import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class PhoneNumberInput extends StatelessWidget {
  PhoneNumberInput(this._onPhoneNumberChange, this.hintText);

  final void Function(String, String, String) _onPhoneNumberChange;
  final String hintText;

  @override
  Widget build(BuildContext context) => InternationalPhoneInput(
        hintText: hintText,
        onPhoneNumberChange: _onPhoneNumberChange,
        initialPhoneNumber: '',
        initialSelection: '',
        enabledCountries: const <String>[
          '+91',
        ],
      );
}
