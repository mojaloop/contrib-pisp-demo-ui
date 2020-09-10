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

      Get.put(userDataController);
      Get.put(navigator);
    },
  );

  test(
    'onTapNext() no phone number entered, goes to phone number entry screen',
    () {
      reset(userDataController);
      when(userDataController.phoneNumberAssociated).thenReturn(false);
      setupController.googleLogin = true;
      setupController.googleLoginPrompt = false;
      setupController.onTapNext();
      expect(setupController.googleLoginPrompt, false);
      verify(navigator.toNamed('/phone_number'));
    },
  );

  test(
    'onTapNext() previously entered phone number, goes straight to dashboard',
    () {
      reset(userDataController);
      when(userDataController.phoneNumberAssociated).thenReturn(true);
      setupController.googleLogin = true;
      setupController.googleLoginPrompt = false;
      setupController.onTapNext();
      expect(setupController.googleLoginPrompt, false);
      verify(navigator.offAllNamed('/dashboard'));
    },
  );
}
