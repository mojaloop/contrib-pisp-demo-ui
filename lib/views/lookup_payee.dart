import 'package:flutter/material.dart';
import 'package:pispapp/mock_data/account.dart';
import 'package:pispapp/views/payment_finalize.dart';
import 'package:pispapp/widgets/title_text.dart';

import 'transaction_amount.dart';

//class LookupPayee extends StatelessWidget {
//  LookupPayee(this.payeePhoneIsoCode, this.payeePhoneNumber)
//      : accounts =
//            getOtherAccountsByPhone('$payeePhoneIsoCode$payeePhoneNumber');
//
//  final String payeePhoneNumber;
//  final String payeePhoneIsoCode;
//
//  final List<Account> accounts;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Choose Payee Account'),
//      ),
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: ListView.builder(
//              itemBuilder: (
//                BuildContext context,
//                int position,
//              ) {
//                return InkWell(
//                  onTap: () {
//                    Navigator.of(context).push<dynamic>(
//                      MaterialPageRoute<dynamic>(
//                        builder: (
//                          BuildContext context,
//                        ) =>
//                            TransactionAmount(
//                          payerAccount,
//                          accounts[position],
//                        ),
//                      ),
//                    );
//                  },
//                  child: Column(
//                    children: <Widget>[
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.fromLTRB(
//                                  12.0,
//                                  12.0,
//                                  12.0,
//                                  6.0,
//                                ),
//                                child: Text(
//                                  accounts[position].name,
//                                  style: TextStyle(
//                                      fontSize: 22.0,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.fromLTRB(
//                                  12.0,
//                                  6.0,
//                                  12.0,
//                                  12.0,
//                                ),
//                                child: Text(
//                                  accounts[position].accountNumber,
//                                  style: const TextStyle(fontSize: 18.0),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                      Divider(
//                        height: 2.0,
//                        color: Colors.grey,
//                      )
//                    ],
//                  ),
//                );
//              },
//              itemCount: accounts.length,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

class LookupPayee extends StatelessWidget {
  LookupPayee(this.payeePhoneIsoCode, this.payeePhoneNumber)
      : accounts =
            getOtherAccountsByPhone('$payeePhoneIsoCode$payeePhoneNumber');

  final String payeePhoneNumber;
  final String payeePhoneIsoCode;

  final List<Account> accounts;

  Widget _buildPayeeTile(Account account, BuildContext context) {
    return ListTile(
      onTap: () {Navigator.of(context).push<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PaymentFinalize(account),
        ),
      );},

      leading: const CircleAvatar(),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: account.name,
        fontSize: 14,
      ),
    );
  }

  List<Widget> _columnWidgets(BuildContext context) {
    final List<Widget> widgets = <Widget>[
      const Padding(
        padding: EdgeInsets.fromLTRB(10, 40, 0, 50),
        child: TitleText(
          text: 'Choose Payee',
          fontSize: 20,
        ),
      ),
    ];

    final List<Widget> bankWidgets = <Widget>[];

    for (final Account acc in accounts) {
      bankWidgets.add(_buildPayeeTile(acc, context));
    }

    if(accounts.length == 0) {
      bankWidgets.add(TitleText(text: 'No payee accounts found'));
    }

    widgets.addAll(bankWidgets);

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _columnWidgets(context),
          ),
        ),
      ),
    );
  }
}
