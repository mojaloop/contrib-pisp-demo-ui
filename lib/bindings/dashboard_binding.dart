import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/controllers/ephemeral/dashboard_controller.dart';
import 'package:pispapp/controllers/ephemeral/payment_initiate_controller.dart';
import 'package:pispapp/controllers/ephemeral/profile_controller.dart';
import 'package:pispapp/repositories/mocks/mock_transaction_repository.dart';

class DashboardBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController());

    
  }
}