import 'package:flutter/material.dart';
import 'package:pispapp/mock_data/account.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails(this._account);

  final Account _account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '\nTotal Balance\n',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18),
                        ),
                        TextSpan(
                          text: '\$ ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 30),
                        ),
                        TextSpan(
                          text: _account.balance,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
