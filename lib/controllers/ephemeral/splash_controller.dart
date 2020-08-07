import 'package:get/get.dart';
import 'package:pispapp/routes/custom_navigator.dart';

class SplashController extends GetxController {
  void onButtonClick() {
    Get.find<CustomNavigator>().toNamed('/login');
  }
}
