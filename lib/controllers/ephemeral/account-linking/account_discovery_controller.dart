import 'package:get/get.dart';

class AccountLookupController extends GetxController {
  String opaqueId;

  void onIDChange(String opaqueId) {
    this.opaqueId = opaqueId;
  }
}
