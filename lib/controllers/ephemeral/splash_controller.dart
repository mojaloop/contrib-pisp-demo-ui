import 'package:get/get.dart';
import 'package:pispapp/routes/app_navigator.dart';

class SplashController extends GetxController {
  void onButtonClick() {
    Get.find<AppNavigator>().toNamed('/login');
  }
}
