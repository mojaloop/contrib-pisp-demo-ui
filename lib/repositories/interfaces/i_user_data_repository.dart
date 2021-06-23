import 'dart:async';

import 'package:pispapp/models/auxiliary_user_info.dart';

typedef AuxiliaryUserInfoHandler = void Function(AuxiliaryUserInfo);

/// Abstraction for methods related to read/write user data
/// from external data sources.
abstract class IUserDataRepository {
  /// Create an entry for the user in the DB.
  /// In the future, the entry will store [AuxiliaryUserInfo] related to the user
  /// such as phone number, date of registration etc.
  Future<void> createUserEntryInDB(String userId);

  /// Load the relevant [AuxiliaryUserInfo] for the user with [userId]
  Future<AuxiliaryUserInfo> loadAuxiliaryInfoForUser(String userId);

  /// Listens on the values for an updated set of accounts for a givenUserId
  void Function() listen(String userId, {AuxiliaryUserInfoHandler onValue});
}
