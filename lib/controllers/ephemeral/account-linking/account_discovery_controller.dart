import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/repositories/firebase/consent_repository.dart';

class AccountDiscoveryController extends GetxController {
  String documentId;
  String opaqueId;
  ConsentRepository _repository = ConsentRepository();
   
  Future<void> initiateLookup(String fspId) {
    final String userId = Get.find<AuthController>().user.id;
    Map<String, dynamic> data =
    _repository.add()
  }

  Future<void> listenForAccounts() {

  }

  void onIDChange(String opaqueId) {
    this.opaqueId = opaqueId;
  }
}
