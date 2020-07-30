import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:pispapp/ui/pages/login.dart';
import 'package:pispapp/ui/pages/pin_entry.dart';
=======
import 'package:pispapp/ui/pages/dashboard.dart';
import 'package:pispapp/ui/pages/login.dart';
>>>>>>> master
import 'package:pispapp/ui/pages/profile.dart';
import 'package:pispapp/ui/pages/splash.dart';

part './app_routes.dart';

// ignore: avoid_classes_with_only_static_members
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => Login(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => Profile(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => Dashboard(),
    ),
    GetPage(
      name: Routes.PIN_ENTRY,
      page: () => PinEntry(),
    ),
  ];
}
