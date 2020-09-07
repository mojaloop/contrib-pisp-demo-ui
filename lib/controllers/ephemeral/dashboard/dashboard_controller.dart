import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/available_fsp_controller.dart';
import 'package:pispapp/controllers/ephemeral/dashboard/account_dashboard_controller.dart';
import 'package:pispapp/controllers/ephemeral/profile_controller.dart';
import 'package:pispapp/repositories/firebase/participant_repository.dart';
import 'package:pispapp/repositories/firebase/transaction_repository.dart';
import 'package:pispapp/ui/pages/account-linking/available_fsp.dart';

import 'package:pispapp/ui/pages/account_dashboard.dart';
import 'package:pispapp/ui/pages/payment/payment_initiation.dart';
import 'package:pispapp/ui/pages/profile.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    AccountDashboard(),
    AvailableFSPScreen(),
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

    Get.put<AvailableFSPController>(
      AvailableFSPController(ParticipantRepository()),
    );
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
