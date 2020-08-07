import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/config/config.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/ephemeral/dashboard_controller.dart';
import 'package:pispapp/repositories/account_repository.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/repositories/stubs/stub_account_repository.dart';
import 'package:pispapp/routes/app_pages.dart';
import 'package:pispapp/routes/custom_navigator.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initAppControllers();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Get.find<AuthController>().user == null ? '/' : 'dashboard',
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}

// Initialize controllers which maintain global app state
void initAppControllers() {
  Get.put(AuthController(AuthRepository()));

  if (ACCOUNT_STUB)
    Get.put(AccountController(StubAccountRepository()));
  else
    Get.put(AccountController(AccountRepository()));

  Get.put(DashboardController());
  Get.put(CustomNavigator());
}
