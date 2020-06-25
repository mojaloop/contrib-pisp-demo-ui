import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:pispapp/MockData/Account.dart';
import 'package:pispapp/log_printer.dart';
import 'package:pispapp/Screens/TransactionAmount.dart';

class LookupPayee extends StatefulWidget {
  final Account payerAccount;
  final String payeePhoneNumber;
  final String payeePhoneIsoCode;

  LookupPayee(this.payerAccount, this.payeePhoneIsoCode, this.payeePhoneNumber);
  @override
  _LookupPayeeState createState() =>
      _LookupPayeeState(payerAccount, payeePhoneIsoCode, payeePhoneNumber);
}

class _LookupPayeeState extends State<LookupPayee> {
  final Account payerAccount;
  final String payeePhoneNumber;
  final String payeePhoneIsoCode;

  _LookupPayeeState(
      this.payerAccount, this.payeePhoneIsoCode, this.payeePhoneNumber);

  Account payeeAccount;

  List<Account> accounts = List<Account>();

  @override
  void initState() {
    super.initState();

    var logger = getLogger('LookupPayee');
    logger.e("$payeePhoneIsoCode$payeePhoneNumber");
    accounts = getOtherAccountsByPhone("$payeePhoneIsoCode$payeePhoneNumber");
    for(var account in accounts) logger.e(account.name);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text('Choose Payee Account'),
        ),
        body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, position) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TransactionAmount(payerAccount, accounts[position]),
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
                                style: TextStyle(fontSize: 18.0),
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
