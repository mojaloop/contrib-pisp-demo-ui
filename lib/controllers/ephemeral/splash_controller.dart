import 'package:get/get.dart';

class SplashController extends GetxController {
  void onButtonClick() {
    Get.toNamed<dynamic>('/login');
  }
}
