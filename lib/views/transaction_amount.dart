import 'package:flutter/material.dart';
import 'package:pispapp/mock_data/account.dart';
import 'package:pispapp/views/dashboard.dart';
import 'package:pispapp/views/transaction_details.dart';

class TransactionAmount extends StatefulWidget {
  const TransactionAmount(this.payerAccount, this.payeeAccount);

  final Account payerAccount, payeeAccount;

  @override
  _TransactionAmountState createState() =>
      _TransactionAmountState(payerAccount, payeeAccount);
}

class _TransactionAmountState extends State<TransactionAmount> {
  _TransactionAmountState(this.payerAccount, this.payeeAccount);

  final Account payerAccount, payeeAccount;
  String amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Amount')),
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 170.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 40.0,
                  height: 2.0,
                  color: Colors.white,
                ),
                onChanged: (String text) {
                  amount = text;
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(
                  22.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        heroTag: 'cancel',
                        onPressed: () {
                          Navigator.of(context).push<dynamic>(
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => Dashboard(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.clear,
                        ),
                        backgroundColor: Colors.red,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        heroTag: 'forward',
                        onPressed: () {
                          Navigator.of(context).push<dynamic>(
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  TransactionDetails(
                                payerAccount,
                                payeeAccount,
                                amount,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
