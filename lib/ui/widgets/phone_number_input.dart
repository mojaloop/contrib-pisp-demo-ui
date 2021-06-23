import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pispapp/models/phone_number.dart';

class PhoneNumberInput extends StatefulWidget {
  PhoneNumberInput({this.onUpdate, this.hintText, this.initialValue});

  final String hintText;
  final PISPPhoneNumber initialValue;
  PISPPhoneNumber currentValue;
  final void Function(PISPPhoneNumber, bool) onUpdate;

  @override
  _PhoneNumberInputState createState() =>
      _PhoneNumberInputState(onUpdate: onUpdate);
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  _PhoneNumberInputState({this.onUpdate, this.hintText, this.initialValue});

  final String hintText;
  final PISPPhoneNumber initialValue;
  PISPPhoneNumber currentValue;

  final void Function(PISPPhoneNumber, bool) onUpdate;

  // TODO: get this from the locale for a better UI
  PhoneNumber initialPhoneNumber = PhoneNumber(isoCode: 'TZ');

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          useEmoji: false,
        ),
        hintText: hintText,
        autoValidateMode: AutovalidateMode.disabled,
        onInputChanged: (PhoneNumber number) {
          currentValue = PISPPhoneNumber(number.dialCode, number.parseNumber());
        },
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        onInputValidated: (bool valid) {
          onUpdate(currentValue, valid);
        },
        initialValue: initialPhoneNumber);
  }
}
