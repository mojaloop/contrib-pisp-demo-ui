import 'package:flutter/material.dart';
import 'package:pispapp/Screens/TransactionSuccess.dart';
import 'package:pispapp/Screens/NewPayment.dart';
import 'package:pispapp/Screens/Account.dart';
import 'package:pispapp/Screens/TransactionDetails.dart';
import 'package:pispapp/Screens/AccountDashboard.dart';

import 'package:pispapp/MockData/Account.dart';

class Dashboard extends StatelessWidget {
  List<Account> accounts;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'My Accounts'),
                Tab(text: 'Pay Now'),
              ],
            ),
            title: Center(child: Text('Mojapay')),
          ),
          body: TabBarView(
            children: [
              AccountDashboard(),
              NewPayment(),
            ],
          ),
        ),
      ),
    );
  }
}
