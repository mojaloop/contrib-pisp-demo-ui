import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/controllers/ephemeral/dashboard/dashboard_controller.dart';

void main() {
  DashboardController dashboardController;
  setUp(
    () {
      dashboardController = DashboardController();
    },
  );

  test('onItemTapped sets index correctly', () {
    dashboardController.onItemTapped(1);
    expect(dashboardController.selectedIndex, 1);
    dashboardController.onItemTapped(2);
    expect(dashboardController.selectedIndex, 2);
  });
}
