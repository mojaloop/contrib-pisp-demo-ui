import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';

class ProfileController extends GetxController {
  Future<void> onLogout() async {
    await Get.find<AuthController>().signOut();
    Get.offAllNamed<dynamic>('/');
  }
}
