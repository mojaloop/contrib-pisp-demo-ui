import 'package:flutter/material.dart';
import 'package:pispapp/log_printer.dart';
import '../MockData/Account.dart';
import 'package:pispapp/Screens/phone_number.dart';

class NewPayment extends StatefulWidget {
  @override
  _NewPaymentState createState() => _NewPaymentState();
}

class _NewPaymentState extends State<NewPayment> {
  List<Account> _Accounts = List<Account>();
  Account selectedAccount;
  

  _NewPaymentState() {
    var accounts = getMyDummyAccounts();
    for (var account in accounts) {
      if (account.linked != null && account.linked) _Accounts.add(account);
    }
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
          'Enter Payee Phone Number',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: PhoneNumberInput(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Align(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.arrow_forward)),
                      onTap: ()  {
                        
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
