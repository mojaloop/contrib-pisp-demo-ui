import 'package:get/get.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/firebase/auth_repository.dart';
import 'package:pispapp/repositories/firebase/user_data_repository.dart';

/// Single user
/// Created either upon sign in or app startup
class UserDataController extends GetxController {
  UserDataController(this._userDataRepository, this._user);

  UserDataRepository _userDataRepository;
  User _user;
  AuxiliaryUserInfo userInfo = AuxiliaryUserInfo();

  bool get phoneNumberAssociated => userInfo?.phoneNumber != null;
  ///
  Future<void> loadAuxiliaryInfoForUser() async => userInfo = await _userDataRepository.loadAuxiliaryInfoForUser(_user.id);

  ///
  Future<void> associatePhoneNumberWithUser(PhoneNumber number) => _userDataRepository.associateUserWithPhoneNumber(_user.id, number);

  ///
  Future<void> createUserEntryInDB() =>_userDataRepository.createUserEntryInDB(_user.id);

  void setPhoneNumber(PhoneNumber phoneNumber) {
    userInfo.phoneNumber = phoneNumber;
    update();
  }

  void setUserRegistrationDate(String date) {
    userInfo.registrationDate = date;
    update();
  }
}
