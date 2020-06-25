import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pispapp/MockData/account.dart';
import 'package:pispapp/log_printer.dart';

import 'transaction_amount.dart';

class LookupPayee extends StatefulWidget {

  const LookupPayee(
      this.payerAccount, this.payeePhoneIsoCode, this.payeePhoneNumber);
  
  final Account payerAccount;
  final String payeePhoneNumber;
  final String payeePhoneIsoCode;

  
  @override
  _LookupPayeeState createState() =>
      _LookupPayeeState(payerAccount, payeePhoneIsoCode, payeePhoneNumber);
}

class _LookupPayeeState extends State<LookupPayee> {
  _LookupPayeeState(
      this.payerAccount, this.payeePhoneIsoCode, this.payeePhoneNumber);

  final Account payerAccount;
  final String payeePhoneNumber;
  final String payeePhoneIsoCode;

  Account payeeAccount;

  List<Account> accounts = <Account>[];

  @override
  void initState() {
    super.initState();

    final Logger logger = getLogger('LookupPayee');
    logger.e('$payeePhoneIsoCode$payeePhoneNumber');
    accounts = getOtherAccountsByPhone('$payeePhoneIsoCode$payeePhoneNumber');
    for (final Account account in accounts) {
      logger.e(account.name);
    }
  }

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
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push<dynamic>(
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => TransactionAmount(
                              payerAccount, accounts[position]),
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
                                      12.0, 12.0, 12.0, 6.0),
                                  child: Text(
                                    accounts[position].name,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 6.0, 12.0, 12.0),
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
        ));
  }
}
