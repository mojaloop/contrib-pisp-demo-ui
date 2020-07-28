import 'package:get/get.dart';
import 'package:pispapp/bindings/login_binding.dart';
import 'package:pispapp/bindings/lookup_payee_bindings.dart';
import 'package:pispapp/bindings/payment_details_binding.dart';
import 'package:pispapp/bindings/payment_finalize_bindings.dart';
import 'package:pispapp/bindings/splash_binding.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/ui/pages/dashboard.dart';
import 'package:pispapp/ui/pages/login.dart';
import 'package:pispapp/ui/pages/lookup_payee.dart';
import 'package:pispapp/ui/pages/payment_details.dart';
import 'package:pispapp/ui/pages/payment_finalize.dart';
import 'package:pispapp/ui/pages/splash.dart';

part './app_routes.dart';

// ignore: avoid_classes_with_only_static_members
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: ()  {
        Get.find<AccountDashboardController>().onRefresh();
        return Dashboard();
      }
      // binding: DashboardBinding(),

    ),
    GetPage(
      name: Routes.TRANSFER_LOOKUP,
      page: () => LookupPayee(),
      binding: LookupPayeeBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER_FINALIZE,
      page: () => PaymentFinalize(),
      binding: PaymentFinalizeBinding(),
    ),
    GetPage(
      name: Routes.TRANSGER_DETAILS,
      page: () => PaymentDetails(),
      binding: PaymentDetailsBinding(),
    ),
  ];
}
