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
          resizeToAvoidBottomInset: false,
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
              // TODO (LD) - removed for now... not using this.
              //BottomNavigationBarItem(
              //  icon: Icon(Icons.person_outline),
              //  label: 'Profile',
              //),
            ],
            currentIndex: value.selectedIndex,
            fixedColor: LightColor.darkgrey,
            unselectedItemColor: Colors.grey.shade400,
            onTap: value.onItemTapped,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
