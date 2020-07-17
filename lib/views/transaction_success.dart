import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pispapp/theme/light_color.dart';
import 'package:pispapp/widgets/title_text.dart';

import 'dashboard.dart';

class TransactionSuccess extends StatefulWidget {
  @override
  _TransactionSuccessState createState() => _TransactionSuccessState();
}

class _TransactionSuccessState extends State<TransactionSuccess> {
  bool _complete = false;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => setState(() {
              _complete = true;
            }));

    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushAndRemoveUntil<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => Dashboard(),
        ),
        (Route<dynamic> route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              LightColor.navyBlue2,
              LightColor.lightBlue2,
            ],
          ),
        ),
        child: _complete
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
//              Image.asset('assets/money.png'),
                    SizedBox(height: 40),
                    TitleText(text: 'Transaction Successful', color: LightColor.yellow2, fontSize: 34,),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(LightColor.yellow2),),
              ),
      ),
    );
  }
}
