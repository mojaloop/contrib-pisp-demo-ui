import 'package:get/get.dart';
import 'package:pispapp/bindings/setup_bindings.dart';
import 'package:pispapp/bindings/splash_bindings.dart';
import 'package:pispapp/controllers/ephemeral/dashboard/account_dashboard_controller.dart';
import 'package:pispapp/ui/pages/account-linking/account_unlinking.dart';
import 'package:pispapp/ui/pages/account-linking/account_linking_initiation.dart';
import 'package:pispapp/controllers/ephemeral/dashboard/dashboard_controller.dart';
import 'package:pispapp/ui/pages/dashboard.dart';
import 'package:pispapp/ui/pages/login_setup.dart';
import 'package:pispapp/ui/pages/payment/payment_initiation.dart';
import 'package:pispapp/ui/pages/phone_number_setup.dart';
import 'package:pispapp/ui/pages/pin_entry.dart';
import 'package:pispapp/ui/pages/splash.dart';
import 'package:pispapp/routes/app_routes.dart';

// Define mapping between named route, widget and the bindings
// ignore: avoid_classes_with_only_static_members
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.SETUP_LOGIN,
      page: () => LoginSetup(),
      binding: SetupBinding(),
    ),
    GetPage(
      name: Routes.SETUP_PHONE,
      page: () => PhoneNumberSetup(),
      binding: SetupBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () {
        print('AppPages - dasboard stuff');
        Get.find<DashboardController>().showAccountsPage();
        Get.find<AccountDashboardController>().refresh();
        return Dashboard();
      },
    ),
    GetPage(
      name: Routes.PAYMENT_INITIATION,
      page: () => PaymentInitiation(),
    ),
    GetPage(
      name: Routes.PIN_ENTRY,
      page: () => PinEntry(),
    ),
    GetPage(
      name: Routes.ACCOUNT_LINKING_INITIATION,
      page: () => AccountLinkingInitiation(),
    ),
    GetPage(
      name: Routes.ACCOUNT_UNLINKING,
      page: () => AccountUnlinking(),
    )
  ];
}
