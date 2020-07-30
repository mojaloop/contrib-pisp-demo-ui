import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/dashboard_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());
  }
}
