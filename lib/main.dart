import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/repositories/stubs/stub_account_repository.dart';
import 'package:pispapp/routes/app_pages.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initAppControllers();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}

void initAppControllers() {
  Get.put(AuthController(AuthRepository()));
  Get.put(AccountController(StubAccountRepository()));
  
}
