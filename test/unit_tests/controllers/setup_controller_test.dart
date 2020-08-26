import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/ephemeral/setup_controller.dart';
import 'package:pispapp/routes/app_navigator.dart';

class MockAuthController extends Mock implements AuthController {}

class MockCustomNavigator extends Mock implements AppNavigator {}

void main() {
  SetupController setupController;
  AuthController authController;
  AppNavigator navigator;

  setUp(
    () {
      setupController = SetupController();
      authController = MockAuthController();
      Get.put(authController);
      navigator = MockCustomNavigator();
      Get.put(navigator);
    },
  );

  test(
    'onPhoneNumberChange()',
    () {
      // // valid input
      // String phoneNumber = '9999999999';
      // String isoCode = 'IN';
      // setupController.onPhoneNumberChange(phoneNumber, '', isoCode);
      // verify(authController.setPhoneNumber(phoneNumber, isoCode));
      // expect(setupController.phoneNumber, phoneNumber);
      // expect(setupController.phoneIsoCode, isoCode);
      // expect(setupController.validPhoneNumber, true);
      // expect(setupController.phoneNumberPrompt, false);

      // // invalid input
      // phoneNumber = '1234';
      // isoCode = 'IN';
      // setupController.onPhoneNumberChange(phoneNumber, '', isoCode);
      // verify(authController.setPhoneNumber('', ''));
      // expect(setupController.phoneNumber, phoneNumber);
      // expect(setupController.phoneIsoCode, isoCode);
      // expect(setupController.validPhoneNumber, false);
      // expect(setupController.phoneNumberPrompt, false);
    },
  );

  test(
    'onTapNext() invalid case',
    () {
      setupController.googleLogin = false;
      setupController.onTapNext();
      expect(setupController.googleLoginPrompt, true);
    },
  );
}
