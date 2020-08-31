import 'package:get/get.dart';

class AccountDiscoveryController extends GetxController {
  String opaqueId;

  void onIDChange(String opaqueId) {
    this.opaqueId = opaqueId;
  }
}
