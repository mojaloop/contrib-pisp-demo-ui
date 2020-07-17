import 'package:flutter/material.dart';
import 'package:pispapp/views/account_dashboard.dart';
import 'package:pispapp/views/new_payment.dart';
import 'package:pispapp/views/payment_initiate.dart';
import 'package:pispapp/views/splash.dart';
import 'package:pispapp/widgets/bottom_navigation.dart';

import 'package:pispapp/views/login.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget widgetToShow = AccountDashboard();

  void changeRootWidget(Widget widget) {
    setState(() {
      widgetToShow = widget;
    });
  }

  static List<BottomNavigationButton> buttons = <BottomNavigationButton>[

    BottomNavigationButton(
      Icons.home,
      AccountDashboard(),
    ),
    BottomNavigationButton(
      Icons.transfer_within_a_station,
      PaymentStart(),
    ),
    BottomNavigationButton(
      Icons.person_outline,
      const Center(child: Text('Settings')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(buttons, changeRootWidget),
      body: widgetToShow,
    );
  }
}
