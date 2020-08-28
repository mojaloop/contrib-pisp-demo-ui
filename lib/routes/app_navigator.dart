import 'package:get/get.dart';

class AppNavigator {
  void toNamed(String route) {
    Get.toNamed<dynamic>(route);
  }

  void offAllNamed(String route) {
    Get.offAllNamed<dynamic>(route);
  }
}
