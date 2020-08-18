import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/controllers/ephemeral/profile_controller.dart';
import 'package:pispapp/repositories/stubs/stub_transaction_repository.dart';
import 'package:pispapp/repositories/transaction_repository.dart';
import 'package:pispapp/ui/pages/account-linking/available_fsp.dart';

import 'package:pispapp/ui/pages/account_dashboard.dart';
import 'package:pispapp/ui/pages/payment_initiate.dart';
import 'package:pispapp/ui/pages/profile.dart';

import 'account-linking/available_fsp_controller.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    AccountDashboard(),
    AvailableFSPScreen(),
    PaymentInitiate(),
    Profile(),
  ];

  @override
  void onInit() {
    if (Config.TRANSACTION_STUB) {
      Get.put<AccountDashboardController>(
          AccountDashboardController(StubTransactionRepository()));
      Get.put<PaymentInitiateController>(
          PaymentInitiateController(StubTransactionRepository()));
    } else {
      Get.put<AccountDashboardController>(
          AccountDashboardController(TransactionRepository()));
      Get.put<PaymentInitiateController>(
          PaymentInitiateController(TransactionRepository()));
    }

    Get.put<ProfileController>(ProfileController());
    Get.put<AvailableFSPController>(AvailableFSPController());
  }

  @override
  void onClose() {}

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
