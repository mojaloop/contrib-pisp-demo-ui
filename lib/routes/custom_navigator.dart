import 'package:get/get.dart';

class CustomNavigator {
  void toNamed(String route) {
    Get.toNamed<dynamic>(route);
  }

  void offAllNamed(String route) {
    Get.offAllNamed<dynamic>(route);
  }

}