import 'package:pispapp/models/user.dart';

/// Abstraction for methods related to read/write authentication
/// information from external data sources.
abstract class IAuthRepository {
  /// Prompts the user to sign in using their Google account.
  /// This function is expected to run asynchronously and return
  /// a user object that represents the user once they complete
  /// the sign in process.
  Future<User> signInWithGoogle();

  /// Signs user out from their account. The execution of this
  /// function will depend on the login type that was used by the
  /// user. If the user signed in using their Google account, then
  /// the execution will also handle the sign out of their Google account.
  Future<void> signOut(User user);

  /// Create an entry for the user in the DB.
  /// This will store [AuxiliaryUserInfo] related to the user such as
  /// phone number, date of registration etc.
  Future<void> createUserEntryInDB(String userId);
}
