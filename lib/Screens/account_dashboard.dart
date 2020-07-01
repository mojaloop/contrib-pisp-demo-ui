import 'package:flutter/material.dart';
import 'package:pispapp/MockData/account.dart';
import 'package:pispapp/Screens/account_details.dart';

class AccountDashboard extends StatefulWidget {
  @override
  _AccountDashboardState createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  List<Account> accounts = <Account>[];

  @override
  void initState() {
    super.initState();

    accounts = getMyDummyAccounts();
    accounts = accounts.where((Account element) => element.linked).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int position) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push<dynamic>(
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          AccountDetails(accounts[position]),
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.green)),
            onPressed: () {},
            color: Colors.green,
            textColor: Colors.white,
            child: Text('Link New Account'.toUpperCase(),
                style: const TextStyle(fontSize: 14)),
          ),
        )
      ],
    ));
  }
}
