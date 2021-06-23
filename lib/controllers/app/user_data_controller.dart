import 'package:get/get.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/firebase/user_data_repository.dart';

/// Controls user data for a single user
/// Created either upon sign in (in signInWithGoogle() from
/// auth_controller.dart) OR during app startup (in setupCurrentUser()
///  in main.dart)
///
/// This controller is created after a user exists in the context of the app.
/// i.e. User has logged in.
class UserDataController extends GetxController {
  UserDataController(this._userDataRepository, this._user);

  UserDataRepository _userDataRepository;
  User _user;
  AuxiliaryUserInfo userInfo = AuxiliaryUserInfo();

  bool get phoneNumberAssociated => userInfo?.phoneNumber != null;

  Future<void> loadAuxiliaryInfoForUser() async =>
      userInfo = await _userDataRepository.loadAuxiliaryInfoForUser(_user.id);

  Future<void> associatePhoneNumberWithUser(PISPPhoneNumber number) =>
      _userDataRepository.associatePhoneNumberWithUser(_user.id, number);

  Future<void> setDemoType(DemoType demoType) =>
      _userDataRepository.setDemoType(_user.id, demoType);

  Future<void> setLiveSwitchLinkingScenario(
          LiveSwitchLinkingScenario linkingScenario) =>
      _userDataRepository.setLiveSwitchLinkingScenario(
          _user.id, linkingScenario);

  Future<void> createUserEntryInDB() =>
      _userDataRepository.createUserEntryInDB(_user.id);

  void setPhoneNumber(PISPPhoneNumber phoneNumber) {
    userInfo.phoneNumber = phoneNumber;
    update();
  }

  PISPPhoneNumber getPhoneNumber() {
    return userInfo.phoneNumber;
  }

  void setUserRegistrationDate(String date) {
    userInfo.registrationDate = date;
    update();
  }

  DemoType getDemoType() {
    return userInfo.demoType;
  }

  LiveSwitchLinkingScenario getLiveSwitchLinkingScenario() {
    return userInfo.liveSwitchLinkingScenario;
  }
}
