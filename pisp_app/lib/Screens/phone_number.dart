import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String phoneNumber;
  String phoneIsoCode;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mojapay'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Welcome to Mojapay. Please enter your phone number',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                PhoneNumberInput(onPhoneNumberChange),
              ],
            ),
          ),
        ));
  }
}

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput(this._onPhoneNumberChange);

  final void Function(String, String, String) _onPhoneNumberChange;


  @override
  Widget build(BuildContext context) => InternationalPhoneInput(
          hintText: 'Enter Phone Number',
          onPhoneNumberChange: _onPhoneNumberChange,
          initialPhoneNumber: '',
          initialSelection: '',
          enabledCountries: const <String>[
            '+91',
          ]);
}
