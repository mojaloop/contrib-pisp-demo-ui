import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/pin_entry_controller.dart';
import 'package:pispapp/repositories/auth_repository.dart';
import 'package:pispapp/routes/app_pages.dart';
import 'package:pispapp/ui/pages/splash.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

import 'controllers/app/auth_controller.dart';
import 'controllers/ephemeral/local_auth_controller.dart';
import 'controllers/ephemeral/login_controller.dart';
import 'controllers/ephemeral/profile_controller.dart';
import 'controllers/ephemeral/splash_controller.dart';

void main() {
  // Ensures flutter binding is created even before runApp() so
  // binary messenger can be used for async code
  WidgetsFlutterBinding.ensureInitialized();

  initControllers();

  runApp(LifecycleAwareApp());
}

// Wrapper class to allow app-wide lifecycle listening
class LifecycleAwareApp extends StatefulWidget {
  @override
  _LifecycleAwareAppState createState() => _LifecycleAwareAppState();
}

class _LifecycleAwareAppState extends State<LifecycleAwareApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // Show verification screen when app first starts
    Get.find<LocalAuthController>().appWasResumed();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Get.find<LocalAuthController>().appWasResumed();
    }
    else if (state == AppLifecycleState.paused) {
      Get.find<LocalAuthController>().appWasPaused();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      home: SplashScreen(),
    );
  }
}


void initControllers() {
  Get.put(AuthController(AuthRepository()));
  Get.put(SplashController());
  Get.put(LoginController());
  Get.put(ProfileController());
  Get.put(PINEntryController());
  Get.put(LocalAuthController());
}

