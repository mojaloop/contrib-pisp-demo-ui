import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/dashboard/dashboard_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (value) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: value.widgetOptions.elementAt(value.selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance),
                label: 'Accounts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: 'Link',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.transfer_within_a_station),
                label: 'Transfer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile'
              ),
            ],
            currentIndex: value.selectedIndex,
            fixedColor: LightColor.navyBlue2,
            unselectedItemColor: Colors.black,
            onTap: value.onItemTapped,
          ),
        );
      },
    );
  }
}
