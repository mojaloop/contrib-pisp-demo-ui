import 'package:flutter/material.dart';
import 'package:pispapp/MockData/account.dart';
import 'package:pispapp/Screens/lookup_payee.dart';
import 'package:pispapp/Screens/phone_number.dart';

class NewPayment extends StatefulWidget {
  @override
  _NewPaymentState createState() => _NewPaymentState();
}

class _NewPaymentState extends State<NewPayment> {
  _NewPaymentState() {
    final List<Account> accounts = getMyDummyAccounts();
    _accounts = accounts
        .where(
          (Account element) => element.linked,
        )
        .toList();
  }

  List<Account> _accounts = <Account>[];
  Account selectedAccount;

  String phoneNumber;
  String phoneIsoCode;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(
      () {
        phoneNumber = number;
        phoneIsoCode = isoCode;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const Divider(height: 25),
          const Text(
            'Choose an account',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          const Divider(height: 16),
          DropdownButton<Account>(
            hint: const Text('Select Account'),
            value: selectedAccount,
            items: _accounts.map(
              (Account account) {
                return DropdownMenuItem<Account>(
                  value: account,
                  child: Row(
                    children: <Widget>[
                      Text(
                        account.alias,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
            onChanged: (Account account) {
              setState(() {
                selectedAccount = account;
              });
            },
          ),
          const Divider(
            height: 40,
          ),
          const Text(
            'Payee Phone Number',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const Divider(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              15.0,
              0.0,
              15.0,
              0.0,
            ),
            child: PhoneNumberInput(
              onPhoneNumberChange,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push<dynamic>(
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => LookupPayee(
                          selectedAccount,
                          phoneIsoCode,
                          phoneNumber,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
