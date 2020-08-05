import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
