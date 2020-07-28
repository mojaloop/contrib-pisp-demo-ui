import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}