import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/models/phone_number.dart';
import 'package:pispapp/repositories/firebase/user_data_repository.dart';
import 'package:pispapp/controllers/app/user_data_controller.dart';

class MockUserDataRepository extends Mock implements UserDataRepository {}

void main() {
  UserDataRepository userDataRepository;
  UserDataController userDataController;
  User user;

  setUp(
    () {
      user = User(
          id: '12345',
          name: 'Test User',
          email: 'test@test.com',
          photoUrl: 'image.com',
          loginType: LoginType.google);
      userDataRepository = MockUserDataRepository();
      userDataController = UserDataController(userDataRepository, user);
    },
  );

  test(
    'setPhoneNumber() sets the phone number correctly',
    () {
      userDataController.setPhoneNumber(PISPPhoneNumber('SG', '66666666'));
      expect(userDataController.userInfo.phoneNumber.countryCode, 'SG');
      expect(userDataController.userInfo.phoneNumber.number, '66666666');
    },
  );

  test(
    'setUserRegistrationDate() sets the registration date correctly',
    () {
      userDataController.setUserRegistrationDate('01/01/2020');
      expect(userDataController.userInfo.registrationDate, '01/01/2020');
    },
  );

  test(
    'loadAuxiliaryInfo() correctly loads auxiliary info',
    () async {
      final AuxiliaryUserInfo userInfo = AuxiliaryUserInfo(
          phoneNumber: PISPPhoneNumber('SG', '66666666'),
          registrationDate: '01/01/2020');
      when(userDataRepository.loadAuxiliaryInfoForUser(any))
          .thenAnswer((_) => Future.value(userInfo));

      await userDataController.loadAuxiliaryInfoForUser();

      // Verify the user with the correct user.id was loaded
      verify(userDataRepository.loadAuxiliaryInfoForUser(user.id));

      expect(userDataController.userInfo.phoneNumber.countryCode, 'SG');
      expect(userDataController.userInfo.phoneNumber.number, '66666666');
      expect(userDataController.userInfo.registrationDate, '01/01/2020');
    },
  );

  test(
    'phoneNumberAssociated returns false when no phone number is set',
    () async {
      when(userDataRepository.loadAuxiliaryInfoForUser(any))
          .thenAnswer((_) => Future.value(AuxiliaryUserInfo()));

      await userDataController.loadAuxiliaryInfoForUser();

      expect(userDataController.phoneNumberAssociated, false);
    },
  );

  test(
    'phoneNumberAssociated returns false when no phone number is set',
    () async {
      final AuxiliaryUserInfo userInfo =
          AuxiliaryUserInfo(phoneNumber: PISPPhoneNumber('SG', '66666666'));
      when(userDataRepository.loadAuxiliaryInfoForUser(any))
          .thenAnswer((_) => Future.value(userInfo));

      await userDataController.loadAuxiliaryInfoForUser();

      expect(userDataController.phoneNumberAssociated, true);
    },
  );
}
