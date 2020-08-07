import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/ephemeral/setup_controller.dart';
import 'package:pispapp/routes/custom_navigator.dart';


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
    'onTapNext() valid case',
    () {
      setupController.googleLogin = true;
      setupController.googleLoginPrompt = false;
      setupController.onTapNext();
      expect(setupController.googleLoginPrompt, false);
      verify(navigator.toNamed('/phone_number'));
    },
  );
}
