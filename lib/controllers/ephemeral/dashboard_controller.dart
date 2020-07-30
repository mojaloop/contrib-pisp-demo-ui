import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:pispapp/ui/pages/account_dashboard.dart';
import 'package:pispapp/ui/pages/profile.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    AccountDashboard(),
    const Center(child: Text('Account Linking')),
    const Center(child: Text('Transaction flow')),
    Profile(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
