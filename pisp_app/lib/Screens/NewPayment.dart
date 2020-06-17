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

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    print(listOfBiometrics);
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
            "Please authenticate to view your transaction overview",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      final logger = getLogger('auth user');
      logger.e(e);
    }

    if (!mounted) return;

    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');

    if (isAuthenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FindPayee(),
        ),
      );
    }
  }

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
                      onTap: () async {
                        if (await _isBiometricAvailable()) {
                          await _getListOfBiometricTypes();
                          await _authenticateUser();
                        }
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
