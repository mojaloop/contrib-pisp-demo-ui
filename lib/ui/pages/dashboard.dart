import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/dashboard_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: _.widgetOptions.elementAt(_.selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance),
                title: const Text(
                  'Accounts',
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                title: const Text(
                  'Link',
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.transfer_within_a_station),
                title: const Text(
                  'Transfer',
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                title: const Text(
                  'Profile',
                ),
              ),
            ],
            currentIndex: _.selectedIndex,
            fixedColor: LightColor.navyBlue2,
            unselectedItemColor: Colors.black,
            onTap: _.onItemTapped,
          ),
        );
      },
    );
  }
}