import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/routes/custom_navigator.dart';

class ProfileController extends GetxController {
  Future<void> onLogout() async {
    await Get.find<AuthController>().signOut();
    Get.find<CustomNavigator>().offAllNamed('/');
  }
}
