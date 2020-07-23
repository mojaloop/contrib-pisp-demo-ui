import 'package:get/get.dart';
import 'package:meta/meta.dart';

class SplashController extends GetxController {

  void onButtonClick() {
    Get.toNamed<dynamic>('/login');
  }
}