import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:pispapp/MockData/Account.dart';
import 'package:pispapp/log_printer.dart';
import 'package:pispapp/Screens/AccountDetails.dart';

class AccountDashboard extends StatefulWidget {
  @override
  _AccountDashboardState createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  bool _loading = true;
  List<Account> accounts = List<Account>();
  List<String> androidVersionNames = List<String>();

  @override
  void initState() {
    super.initState();

    accounts = getMyDummyAccounts();
    accounts = accounts.where((element) => element.linked).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, position) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AccountDetails(accounts[position]),
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
                                accounts[position].alias,
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.green)),
            onPressed: () {},
            color: Colors.green,
            textColor: Colors.white,
            child: Text("Link New Account".toUpperCase(),
                style: TextStyle(fontSize: 14)),
          ),
        )
      ],
    ));
  }
}
