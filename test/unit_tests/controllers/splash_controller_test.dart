
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/ephemeral/splash_controller.dart';
import 'package:pispapp/routes/custom_navigator.dart';

class MockCustomNavigator extends Mock implements CustomNavigator{}
void main() {
  SplashController controller;
  CustomNavigator navigator;
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