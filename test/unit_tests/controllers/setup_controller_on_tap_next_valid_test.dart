import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/ephemeral/setup_controller.dart';
import 'package:pispapp/controllers/app/user_data_controller.dart';
import 'package:pispapp/routes/app_navigator.dart';

class MockAppNavigator extends Mock implements AppNavigator {}
class MockUserDataController extends Mock implements UserDataController {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  SetupController setupController;
  AppNavigator navigator;
  UserDataController userDataController;

  setUp(
    () {
      setupController = SetupController();
      navigator = MockAppNavigator();
      userDataController = MockUserDataController();

      setupController.googleLogin = true;
      setupController.googleLoginPrompt = false;

      Get.put(navigator);
      Get.put(userDataController);
    },
  );

  tearDown(
      () {
        Get.delete<UserDataController>();
        Get.delete<AppNavigator>();
      },
  );

  test(
    'onTapNext() - no phone number entered, goes to phone number entry screen',
    () {
      when(userDataController.phoneNumberAssociated)
          .thenReturn(false);
      setupController.onTapNext();
      expect(setupController.googleLoginPrompt, false);
      verify(navigator.toNamed('/phone_number'));
    },
  );

  test(
    'onTapNext() - previously entered phone number, goes straight to dashboard',
    () {
      when(userDataController.phoneNumberAssociated)
          .thenReturn(true);
      setupController.onTapNext();
      expect(setupController.googleLoginPrompt, false);
      verify(navigator.offAllNamed('/dashboard'));
    },
  );
}
