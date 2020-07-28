import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/controllers/ephemeral/profile_controller.dart';
import 'package:pispapp/repositories/mocks/mock_transaction_repository.dart';

import 'package:pispapp/ui/pages/account_dashboard.dart';
import 'package:pispapp/ui/pages/payment_initiate.dart';
import 'package:pispapp/ui/pages/profile.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    AccountDashboard(),
    const Center(child: Text('Account Linking')),
    PaymentInitiate(),
    Profile(),
  ];

  @override
  void onInit() {
    // TODO(MahidharBandaru): Change to the actual firesotre repository once it's created
    Get.put<AccountDashboardController>(
        AccountDashboardController(MockTransactionRepository()));
    Get.put<PaymentInitiateController>(PaymentInitiateController());
    Get.put<ProfileController>(ProfileController());
    // TODO(MahidharBandaru): add account linking controller once it's created
  }

  @override
  void onClose() {}

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}