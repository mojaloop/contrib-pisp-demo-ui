import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/repositories/firebase/consent_repository.dart';

class AccountLookupController extends GetxController {
  String opaqueId;

  void onIDChange(String opaqueId) {
    this.opaqueId = opaqueId;
  }
}
