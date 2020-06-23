import 'package:flutter/material.dart';
import 'package:pispapp/MockData/Account.dart';
import 'package:pispapp/Screens/Dashboard.dart';
import 'package:pispapp/Screens/TransactionDetails.dart';

class TransactionAmount extends StatefulWidget {
  final Account payerAccount, payeeAccount;
  String amount;

  TransactionAmount(this.payerAccount, this.payeeAccount);
  @override
  _TransactionAmountState createState() =>
      _TransactionAmountState(payerAccount, payeeAccount);
}

class _TransactionAmountState extends State<TransactionAmount> {
  final Account payerAccount, payeeAccount;
  String amount;
  _TransactionAmountState(this.payerAccount, this.payeeAccount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Amount')),
      backgroundColor: Colors.green,
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
              width: 170.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style:
                    TextStyle(fontSize: 40.0, height: 2.0, color: Colors.white),
                onChanged: (text) {
                  amount = text;
                },
              )),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.bottomRight,
                          child: ClipOval(
                            child: Material(
                              color: Colors.red, // button color
                              child: InkWell(
                                splashColor: Colors.white, // inkwell color
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(Icons.clear)),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )),
                      Align(
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
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TransactionDetails(
                                          payerAccount, payeeAccount, amount),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )),
                    ])),
          ),
        ],
      )),
    );
  }
}
