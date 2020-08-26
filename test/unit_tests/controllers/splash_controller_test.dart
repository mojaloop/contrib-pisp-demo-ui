import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/ephemeral/splash_controller.dart';
import 'package:pispapp/routes/app_navigator.dart';

class MockCustomNavigator extends Mock implements AppNavigator {}

void main() {
  SplashController controller;
  AppNavigator navigator;
  setUp(() {
    controller = SplashController();
    navigator = MockCustomNavigator();
    Get.put(navigator);
  });

  test('onButtonClick() call navigate to /login', () {
    controller.onButtonClick();
    verify(navigator.toNamed('/login'));
  });
}
