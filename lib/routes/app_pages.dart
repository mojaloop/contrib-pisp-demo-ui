import 'package:get/get.dart';
import 'package:pispapp/ui/pages/account-linking/available_fsp.dart';
import 'package:pispapp/bindings/lookup_payee_bindings.dart';
import 'package:pispapp/bindings/payment_details_bindings.dart';
import 'package:pispapp/bindings/payment_finalize_bindings.dart';
import 'package:pispapp/bindings/payment_verdict_bindings.dart';
import 'package:pispapp/bindings/setup_bindings.dart';
import 'package:pispapp/bindings/splash_bindings.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/ui/pages/dashboard.dart';
import 'package:pispapp/ui/pages/login_setup.dart';
import 'package:pispapp/ui/pages/lookup_payee.dart';
import 'package:pispapp/ui/pages/payment_details.dart';
import 'package:pispapp/ui/pages/payment_finalize.dart';
import 'package:pispapp/ui/pages/payment_verdict.dart';
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
        Get.find<AccountDashboardController>().onRefresh();
        return Dashboard();
      },
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
      name: Routes.TRANSFER_DETAILS,
      page: () => PaymentDetails(),
      binding: PaymentDetailsBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER_VERDICT,
      page: () => PaymentVerdict(),
      binding: PaymentVerdictBinding(),
    ),
    GetPage(
      name: Routes.PIN_ENTRY,
      page: () => PinEntry(),
    ),
    GetPage(
      name: Routes.AVAILABLE_FSP,
      page: () => AvailableFSPScreen(),
    ),
  ];
}
