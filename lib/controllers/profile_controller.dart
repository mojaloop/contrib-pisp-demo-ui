import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pispapp/controllers/auth_controller.dart';
import 'package:pispapp/exceptions/auth_exception.dart';
import 'package:pispapp/uitls/log_printer.dart';


class ProfileController extends GetxController {
  Future<void> onLogout() async {
    try {
      await Get.find<AuthController>().signOut();
      Get.offAllNamed<dynamic>('/');
    } on AuthenticationException catch (_) {
      final logger = getLogger('ProfileController');
      logger.e(_);
    }
  }
}
