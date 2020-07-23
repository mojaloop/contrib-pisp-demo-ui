import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/routes/app_pages.dart';
import 'package:pispapp/ui/pages/splash.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

import 'controllers/auth_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/splash_controller.dart';


void main() {
  
  initControllers();


  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
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
}

