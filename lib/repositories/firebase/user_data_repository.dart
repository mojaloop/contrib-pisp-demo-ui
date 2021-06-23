import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';
import 'package:pispapp/models/phone_number.dart';

import 'package:pispapp/repositories/interfaces/i_user_data_repository.dart';
import 'package:pispapp/utils/log_printer.dart';
import 'package:pispapp/utils/utils.dart';

class UserDataRepository implements IUserDataRepository {
  static const PHONE_NO_KEY = 'phoneNo';
  static const PHONE_NO_COUNTRY_CODE_KEY = 'phoneNoIsoCode';
  static const REGISTRATION_DATE_KEY = 'dateRegistered';
  static const DEMO_TYPE_KEY = 'demoType';
  static const LIVE_SWITCH_LINKING_SCENARIO = 'liveSwitchLinkingScenario';

  static final logger = getLogger('UserDataRepository');

  final Firestore _firestore = Firestore.instance;

  /// Creates a user entry in the database where the document ID is
  /// equal to the user id assigned by Firebase Auth.
  /// We will be able to store [AuxiliaryUserInfo] here later.
  @override
  Future<void> createUserEntryInDB(String uid) async {
    // Check for existing user (if this is not the first sign on)
    final QuerySnapshot s = await _firestore.collection('users').getDocuments();
    final bool userExists =
        s.documents.where((document) => document.documentID == uid).isNotEmpty;
    if (!userExists) {
      // Set Defaults
      final Map<String, dynamic> data = <String, dynamic>{
        REGISTRATION_DATE_KEY: DateTime.now().toIso8601String(),
        DEMO_TYPE_KEY: DemoType.simulatedSwitch.toJsonString(),
        LIVE_SWITCH_LINKING_SCENARIO:
            LiveSwitchLinkingScenario.none.toJsonString(),
      };
      _firestore.collection('users').document(uid).setData(data);
      logger.d('Firestore entry created for $uid');
    }
  }

  /// Loads any [AuxiliaryUserInfo] for the user that we may want to store
  /// such as phone number, date of registration etc.
  @override
  Future<AuxiliaryUserInfo> loadAuxiliaryInfoForUser(String uid) async {
    return _firestore.collection('users').document(uid).get().then((userEntry) {
      if (userEntry?.data == null) {
        return AuxiliaryUserInfo();
      }
      final Map<String, dynamic> userData = userEntry.data;
      // Currently only phone number but can be extended to populate other fields
      final String phoneNo =
          userData[UserDataRepository.PHONE_NO_KEY] as String;
      final String countryCode =
          userData[UserDataRepository.PHONE_NO_COUNTRY_CODE_KEY] as String;
      final String dateRegistered =
          userData[UserDataRepository.REGISTRATION_DATE_KEY] as String;
      final PISPPhoneNumber number = (phoneNo == null || countryCode == null)
          ? null
          : PISPPhoneNumber(countryCode, phoneNo);

      final DemoType demoType =
          Utils.$enumDecodeNullable(DemoTypeEnumMap, userData[DEMO_TYPE_KEY]);
      final LiveSwitchLinkingScenario liveSwitchLinkingScenario =
          Utils.$enumDecodeNullable(LiveSwitchLinkingScenarioMap,
              userData[LIVE_SWITCH_LINKING_SCENARIO]);

      return AuxiliaryUserInfo(
          phoneNumber: number,
          registrationDate: dateRegistered,
          demoType: demoType,
          liveSwitchLinkingScenario: liveSwitchLinkingScenario);
    });
  }

  /// Associates the user with a particular phone number. Used to persist
  /// user phone number data across sessions.
  Future<void> associatePhoneNumberWithUser(
      String uid, PISPPhoneNumber num) async {
    final Map<String, dynamic> phoneNumberData = <String, dynamic>{
      PHONE_NO_KEY: num.number,
      PHONE_NO_COUNTRY_CODE_KEY: num.countryCode
    };
    _firestore
        .collection('users')
        .document(uid)
        .setData(phoneNumberData, merge: true);
  }

  Future<void> setDemoType(String uid, DemoType demoType) async {
    final Map<String, dynamic> data = <String, dynamic>{
      DEMO_TYPE_KEY: demoType.toString(),
    };

    return _firestore
        .collection('users')
        .document(uid)
        .setData(data, merge: true);
  }

  Future<void> setLiveSwitchLinkingScenario(
      String uid, LiveSwitchLinkingScenario linkingScenario) async {
    final Map<String, dynamic> data = <String, dynamic>{
      LIVE_SWITCH_LINKING_SCENARIO: linkingScenario.toString(),
    };

    return _firestore
        .collection('users')
        .document(uid)
        .setData(data, merge: true);
  }
}
