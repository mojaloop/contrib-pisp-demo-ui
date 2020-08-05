import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/setup_controller.dart';

class SetupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupController>(() => SetupController());
  }
}
