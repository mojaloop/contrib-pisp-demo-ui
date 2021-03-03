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

  final void Function(PISPPhoneNumber) onUpdate;

  @override
  Widget build(BuildContext context) {
    print('initialValue ' + initialValue.toString());
    return InternationalPhoneNumberInput(
        selectorConfig:
            SelectorConfig(selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
        hintText: hintText,
        autoValidateMode: AutovalidateMode.disabled,
        onInputChanged: (PhoneNumber number) {
          currentValue = PISPPhoneNumber(number.dialCode, number.parseNumber());
        },
        onInputValidated: (bool valid) {
          if (valid == true) {
            onUpdate(currentValue);
          }
        },
        initialValue:
            PhoneNumber(phoneNumber: '410237238', dialCode: '+61', isoCode: 'AU'
                // dialCode: initialValue?.countryCode));
                ));
    // initialValue: PhoneNumber(phoneNumber: '410237238', isoCode: 'AU'));
    // countries: Countries.countryCodes);
    // return InternationalPhoneInput(
    //   hintText: hintText,
    //   enabledCountries: Countries.countryCodes,
    //   initialPhoneNumber: initialValue?.number,
    //   initialSelection: initialValue?.countryCode,
    //   onPhoneNumberChange: (phoneNumber, _, isoCode) {
    //     if (onUpdate != null) {
    //       print('onUpdate ' + phoneNumber);
    //       onUpdate(PISPPhoneNumber(isoCode, phoneNumber));
    //     }
    //   },
    // );
  }
}
