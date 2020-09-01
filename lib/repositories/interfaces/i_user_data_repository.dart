import 'dart:async';

import 'package:pispapp/models/auxiliary_user_info.dart';

/// Abstraction for methods related to read/write user data
/// from external data sources.
abstract class IUserDataRepository {
  /// Create an entry for the user in the DB.
  /// In the future, the entry will store [AuxiliaryUserInfo] related to the user
  /// such as phone number, date of registration etc.
  Future<void> createUserEntryInDB(String userId);

  /// Load the relevant [AuxiliaryUserInfo] for the user with [userId]
  Future<AuxiliaryUserInfo> loadAuxiliaryInfoForUser(String userId);
}
