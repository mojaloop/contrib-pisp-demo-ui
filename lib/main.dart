import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/user_pin_auth_controller.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/routes/app_pages.dart';
import 'package:pispapp/ui/pages/pin_entry.dart';
import 'package:pispapp/ui/pages/splash.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

import 'controllers/app/auth_controller.dart';
import 'controllers/ephemeral/login_controller.dart';
import 'controllers/ephemeral/profile_controller.dart';
import 'controllers/ephemeral/splash_controller.dart';

void main() {
  // Ensures flutter binding is created even before runApp() so
  // binary messenger can be used for async code
  WidgetsFlutterBinding.ensureInitialized();

  initControllers();

  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appThemeData,
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
        home: SplashScreen(),
    )
  );
}

void initControllers() {
  Get.put(AuthController(AuthRepository()));
  Get.put(SplashController());
  Get.put(LoginController());
  Get.put(ProfileController());
  Get.put(PINAuthController());
}

