import 'package:flutter/material.dart';
import 'package:pispapp/MockData/account.dart';

import 'transaction_amount.dart';

class LookupPayee extends StatelessWidget {
  LookupPayee(this.payerAccount, this.payeePhoneIsoCode, this.payeePhoneNumber)
      : accounts =
            getOtherAccountsByPhone('$payeePhoneIsoCode$payeePhoneNumber');

  final Account payerAccount;
  final String payeePhoneNumber;
  final String payeePhoneIsoCode;

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Payee Account'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (
                BuildContext context,
                int position,
              ) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push<dynamic>(
                      MaterialPageRoute<dynamic>(
                        builder: (
                          BuildContext context,
                        ) =>
                            TransactionAmount(
                          payerAccount,
                          accounts[position],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12.0,
                                  12.0,
                                  12.0,
                                  6.0,
                                ),
                                child: Text(
                                  accounts[position].name,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12.0,
                                  6.0,
                                  12.0,
                                  12.0,
                                ),
                                child: Text(
                                  accounts[position].accountNumber,
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 2.0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                );
              },
              itemCount: accounts.length,
            ),
          ),
        ],
      ),
    );
  }
}
