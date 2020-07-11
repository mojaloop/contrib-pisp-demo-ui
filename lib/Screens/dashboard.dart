import 'package:flutter/material.dart';
import 'package:pispapp/Screens/account_dashboard.dart';
import 'package:pispapp/Screens/new_payment.dart';
import 'package:pispapp/Screens/splash.dart';
import 'package:pispapp/widgets/bottom_navigation.dart';

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
      Icons.arrow_forward,
      SplashScreen(),
    ),
    BottomNavigationButton(
      Icons.home,
      AccountDashboard(),
    ),
    BottomNavigationButton(
      Icons.transfer_within_a_station,
      NewPayment(),
    ),
    BottomNavigationButton(
      Icons.notifications_none,
      const Text('How are you'),
    ),
    BottomNavigationButton(
      Icons.person_outline,
      const Text('Bye'),
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
