import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';


class PhoneNumberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mojapay'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Welcome to Mojapay. Please enter your phone number',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10),
                PhoneNumberInput(),
              ],
            ),
          ),
        )
    );
  }
}

class PhoneNumberInput extends StatefulWidget {
  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  String phoneNumber;
  String phoneIsoCode;

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  @override
  Widget build(BuildContext context) => InternationalPhoneInput(
      onPhoneNumberChange: onPhoneNumberChange,
      initialPhoneNumber: phoneNumber,
      initialSelection: phoneIsoCode,
      enabledCountries: ['+91', ]
  );
}