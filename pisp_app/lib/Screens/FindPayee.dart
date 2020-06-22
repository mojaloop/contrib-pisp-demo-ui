import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:pispapp/MockData/Account.dart';
import 'package:pispapp/log_printer.dart';

class FindPayee extends StatefulWidget {
  @override
  _FindPayeeState createState() => _FindPayeeState();
}

class _FindPayeeState extends State<FindPayee> {
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

    accounts = getOtherAccountsByPhone('+911233323981');
    androidVersionNames = ['hello', 'hi', 'hello', 'hi', 'hello', 'hi', 'hello', 'hi', 'hello', 'hi', 'hello', 'hi'];
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
        appBar: new AppBar(
          title: new Text('ProgressHUD Demo'),
        ),
        body: new Stack(
          children: <Widget>[
            _progressHUD,
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
                                androidVersionNames[position],
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                androidVersionNames[position],
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "5m",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.star_border,
                                  size: 35.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
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
              itemCount: androidVersionNames.length,
            ),
            new Positioned(
                child: new FlatButton(
                    onPressed: _dismissProgressHUD,
                    child: new Text(_loading ? "Dismiss" : "Show")),
                bottom: 30.0,
                right: 10.0)
          ],
        ));
  }
}
