import 'package:flutter/material.dart';
import 'package:pispapp/MockData/Account.dart';
import 'package:pispapp/Screens/Dashboard.dart';
import 'package:pispapp/Screens/TransactionSuccess.dart';

import 'package:pispapp/log_printer.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';


class TransactionDetails extends StatefulWidget {
  Account payerAccount, payeeAccount;
  String amount;
  TransactionDetails(this.payerAccount, this.payeeAccount, this.amount);

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  bool _isLoading = true;
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  String charges;

  // Simulates api call
  // TODO: To be moved out
  Future sleep1() {
    var logger = getLogger('future');
    return new Future.delayed(const Duration(seconds: 1), () => '10');
  }

  void getTransactionCharges() async {
    charges = await sleep1();
    setState(() {
      _isLoading = false;
    });
  }


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
    final LocalAuthentication _localAuthentication = LocalAuthentication();

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
          builder: (context) =>
              TransactionSuccess()
        ),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    getTransactionCharges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
      ),
      body: _isLoading
          ? Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
          )
          : Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              // height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Stack(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Column(
                              children: <Widget>[
                                Text('Payer Details',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 18)),
                                Divider(
                                  height: 2.0,
                                  color: Colors.grey,
                                ),
                                CardRow('Account Alias',
                                    widget.payerAccount.alias, Colors.black),
                                SizedBox(height: 40),
                                Text('Payee Details',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 18)),
                                Divider(
                                  height: 2.0,
                                  color: Colors.grey,
                                ),
                                CardRow('Account name',
                                    widget.payeeAccount.name, Colors.black),
                                CardRow(
                                    'Phone no',
                                    widget.payeeAccount.phoneNumber,
                                    Colors.black),
                                CardRow('Bank Name',
                                    widget.payeeAccount.bankName, Colors.black),
                                CardRow(
                                    'Account Number',
                                    widget.payeeAccount.accountNumber,
                                    Colors.black),
                                SizedBox(height: 40),
                                Text('Transaction Details',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 18)),
                                Divider(
                                  height: 2.0,
                                  color: Colors.grey,
                                ),
                                CardRow('Amount', widget.amount, Colors.black),
                                CardRow('Type', 'Credit', Colors.black),
                                CardRow('Charges', charges, Colors.black),
                                // MyAlert(),
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(22.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: ClipOval(
                                                  child: Material(
                                                    color: Colors
                                                        .red, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                          .white, // inkwell color
                                                      child: SizedBox(
                                                          width: 56,
                                                          height: 56,
                                                          child: Icon(
                                                              Icons.clear)),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Dashboard(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                )),
                                            Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: ClipOval(
                                                  child: Material(
                                                    color: Colors
                                                        .green, // button color
                                                    child: InkWell(
                                                      splashColor: Colors
                                                          .white, // inkwell color
                                                      child: SizedBox(
                                                          width: 56,
                                                          height: 56,
                                                          child: Icon(Icons
                                                              .arrow_forward)),
                                                      onTap: () async {
                        if (await _isBiometricAvailable()) {
                          await _getListOfBiometricTypes();
                          await _authenticateUser();
                        }
                                                      }
                                                    ),
                                                  ),
                                                )),
                                          ])),
                                ),
                              ],
                            ))
                      ],
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}

class CardRow extends StatelessWidget {
  String left, right;
  Color color;
  CardRow(this.left, this.right, this.color);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: right, style: TextStyle(color: color, fontSize: 16)),
              ])),
            ],
          ),
        ),
        Divider(
          height: 2.0,
          color: Colors.grey,
        )
      ],
    );
  }
}

