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

  PISPPhoneNumber currentValue;

  final void Function(PISPPhoneNumber, bool) onUpdate;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
        selectorConfig:
            SelectorConfig(selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
        hintText: hintText,
        autoValidateMode: AutovalidateMode.disabled,
        onInputChanged: (PhoneNumber number) {
          currentValue = PISPPhoneNumber(number.dialCode, number.parseNumber());
        },
        onInputValidated: (bool valid) {
          onUpdate(currentValue, valid);
        });
  }
}
