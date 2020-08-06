import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/repositories/mocks/mock_account_repository.dart';
import 'package:pispapp/repositories/mocks/mock_transaction_repository.dart';
import 'package:pispapp/routes/app_pages.dart';
import 'package:pispapp/ui/pages/splash.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

import 'controllers/app/account_controller.dart';
import 'controllers/app/auth_controller.dart';
import 'controllers/ephemeral/account-linking/available_fsp_controller.dart';
import 'controllers/ephemeral/dashboard_controller.dart';
import 'controllers/ephemeral/login_controller.dart';
import 'controllers/ephemeral/profile_controller.dart';
import 'controllers/ephemeral/splash_controller.dart';

void main() {
  initControllers();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    home: SplashScreen(),
  ));
}

void initControllers() {
  Get.put(AuthController(AuthRepository()));
  Get.put(SplashController());
  Get.put(LoginController());
  Get.put(ProfileController());
  Get.put(AccountController(MockAccountRepository()));
  Get.put(AccountDashboardController(MockTransactionRepository()));
  Get.put(DashboardController());
  Get.put(AvailableFSPController());
}
