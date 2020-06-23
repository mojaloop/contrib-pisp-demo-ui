import 'package:flutter/material.dart';
import 'package:pispapp/log_printer.dart';
import '../MockData/Account.dart';
import 'package:pispapp/Screens/phone_number.dart';
import 'package:pispapp/Screens/FindPayee.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class NewPayment extends StatefulWidget {
  @override
  _NewPaymentState createState() => _NewPaymentState();
}

class _NewPaymentState extends State<NewPayment> {
  List<Account> _Accounts = List<Account>();
  Account selectedAccount;
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  String phoneNumber;
  String phoneIsoCode;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  _NewPaymentState() {
    var accounts = getMyDummyAccounts();
    _Accounts = accounts.where((element) => element.linked).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(height: 25),
        Text(
          'Choose an account',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 16),
        DropdownButton<Account>(
          hint: Text("Select Account"),
          value: selectedAccount,
          items: _Accounts.map((Account account) {
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
          }).toList(),
          onChanged: (Account account) {
            setState(() {
              selectedAccount = account;
            });
          },
        ),
        SizedBox(height: 60),
        Text(
          'Payee Phone Number',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: PhoneNumberInput(onPhoneNumberChange),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Align(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Material(
                    color: Colors.green, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.arrow_forward)),
                      onTap: () async {
                        // if (await _isBiometricAvailable()) {
                        //   await _getListOfBiometricTypes();
                        //   await _authenticateUser();
                        // }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FindPayee(
                                selectedAccount, phoneIsoCode, phoneNumber),
                          ),
                        );
                      },
                    ),
                  ),
                )),
          ),
        ),
      ],
    ));
  }
}
