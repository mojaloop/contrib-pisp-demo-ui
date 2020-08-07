import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/ephemeral/setup_controller.dart';
import 'package:pispapp/routes/custom_navigator.dart';

class MockAuthController extends Mock implements AuthController {}

class MockCustomNavigator extends Mock implements CustomNavigator {}

void main() {
  SetupController setupController;
  CustomNavigator navigator;
  setUp(
    () {
      setupController = SetupController();
      navigator = MockCustomNavigator();
      Get.put(navigator);
    },
  );


  test(
    'onLogin',
    () {
      setupController.onLogin();
      verify(navigator.offAllNamed('/dashboard'));
    },
  );
}
