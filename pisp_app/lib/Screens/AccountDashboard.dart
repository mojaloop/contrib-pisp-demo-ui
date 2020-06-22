import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:pispapp/MockData/Account.dart';
import 'package:pispapp/log_printer.dart';

class AccountDashboard extends StatefulWidget {
  @override
  _AccountDashboardState createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  ProgressHUD _progressHUD;

  bool _loading = true;
  List<Account> accounts = List<Account>();
  List<String> androidVersionNames = List<String>();

  @override
  void initState() {
    super.initState();

    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.green,
      borderRadius: 5.0,
      text: 'Loading...',
      loading: _loading,
    );

    accounts = getMyDummyAccounts();
    accounts = accounts.where((element) => element.linked == true).toList();
    var logger = getLogger('FindPayee');

    for (var account in accounts) {
      logger.e(account.name);
    }
  }

  void _dismissProgressHUD() {
    setState(() {
      if (_loading) {
        _progressHUD.state.dismiss();
      } else {
        _progressHUD.state.show();
      }

      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            ListView.builder(
              itemBuilder: (context, position) {
                return Column(
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
                );
              },
              itemCount: accounts.length,
            ),
          ],
        ));
  }
}
