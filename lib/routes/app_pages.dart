import 'package:get/get.dart';
import 'package:pispapp/ui/pages/login.dart';
import 'package:pispapp/ui/pages/profile.dart';
import 'package:pispapp/ui/pages/splash.dart';

part './app_routes.dart';

abstract class AppPages {

  static final pages = [
    GetPage(name: Routes.SPLASH, page:()=> SplashScreen(),),
    GetPage(name: Routes.LOGIN, page:()=> Login(),),
    GetPage(name: Routes.PROFILE, page:()=> Profile(),),


  ];
}