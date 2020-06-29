import 'package:flutter/material.dart';
import 'package:pispapp/Screens/account_dashboard.dart';
import 'package:pispapp/Screens/new_payment.dart';

class Dashboard extends StatelessWidget {
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
            bottom: const TabBar(
              tabs: <Tab>[
                Tab(text: 'My Accounts'),
                Tab(text: 'Pay Now'),
              ],
            ),
            title: const Center(child: Text('Mojapay')),
          ),
          body: TabBarView(
            children: <Widget>[
              AccountDashboard(),
              NewPayment(),
            ],
          ),
        ),
      ),
    );
  }
}
