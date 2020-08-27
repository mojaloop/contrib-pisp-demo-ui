import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pispapp/models/auxiliary_user_info.dart';
import 'package:pispapp/models/phone_number.dart';

import 'package:pispapp/repositories/interfaces/i_user_data_repository.dart';
import 'package:pispapp/utils/log_printer.dart';

class UserDataRepository implements IUserDataRepository {
  static const PHONE_NO_KEY = 'phoneNo';
  static const PHONE_NO_COUNTRY_CODE_KEY = 'phoneNoIsoCode';
  static const REGISTRATION_DATE_KEY = 'dateRegistered';

  static final logger = getLogger('UserDataRepository');

  final Firestore _firestore = Firestore.instance;

  @override
  Future<void> createUserEntryInDB(String uid) async {
    // Check for existing user (if this is not the first sign on)
    final QuerySnapshot s = await _firestore.collection('users').getDocuments();
    final bool userExists = s.documents.where((document) => document.documentID == uid).isNotEmpty;
    if(!userExists) {
      final Map<String, dynamic> data = <String, dynamic>{
        REGISTRATION_DATE_KEY: DateTime.now().toIso8601String()
      };
      _firestore.collection('users').document(uid).setData(data);
      logger.d('Firestore entry created for $uid');
    }
  }

  @override
  Future<AuxiliaryUserInfo> loadAuxiliaryInfoForUser(String uid) async {
    return _firestore.collection('users').document(uid).get().then((userEntry) {
      if(userEntry?.data == null) {
        return AuxiliaryUserInfo();
      }
      final Map<String, dynamic> userData = userEntry.data;
      // Currently only phone number but can be extended to populate other fields
      final String phoneNo = userData[UserDataRepository.PHONE_NO_KEY] as String;
      final String countryCode = userData[UserDataRepository.PHONE_NO_COUNTRY_CODE_KEY] as String;
      final String dateRegistered = userData[UserDataRepository.REGISTRATION_DATE_KEY] as String;
      final PhoneNumber number = (phoneNo == null || countryCode == null) ? null : PhoneNumber(countryCode, phoneNo);
      return AuxiliaryUserInfo(phoneNumber: number, registrationDate: dateRegistered);
    });
  }
  Future<void> associateUserWithPhoneNumber(String uid, PhoneNumber num) async {
    final Map<String, dynamic> phoneNumberData = <String, dynamic>{
      PHONE_NO_KEY : num.number,
      PHONE_NO_COUNTRY_CODE_KEY : num.countryCode
    };
    _firestore.collection('users').document(uid).setData(phoneNumberData, merge: true);
  }

}
