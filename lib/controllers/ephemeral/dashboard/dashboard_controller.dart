import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pispapp/controllers/ephemeral/dashboard/account_dashboard_controller.dart';
import 'package:pispapp/controllers/ephemeral/profile_controller.dart';
import 'package:pispapp/repositories/firebase/transaction_repository.dart';

import 'package:pispapp/ui/pages/account_dashboard.dart';
import 'package:pispapp/ui/pages/payment/payment_initiation.dart';
import 'package:pispapp/ui/pages/profile.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    AccountDashboard(),
    const Center(child: Text('Account Linking')),
    PaymentInitiation(),
    Profile(),
  ];

  @override
  void onInit() {
    Get.put<AccountDashboardController>(
      AccountDashboardController(TransactionRepository()),
    );

    Get.put<ProfileController>(
      ProfileController(),
    );

    // TODO(kkzeng): add account linking controller once it's created
  }

  @override
  void onClose() {}

  void showAccountsPage() {
    selectedIndex = 0;
    update();
  }
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
