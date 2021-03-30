import 'package:pispapp/models/account.dart';

typedef AccountHandler = void Function(List<Account>);

/// Abstraction for methods related to read/write account
/// information from external data sources.
abstract class IAccountRepository {
  /// Returns list of accounts that are associated with a particular user.
  Future<List<Account>> getUserAccounts(String userId);

  /// Listens on the values for an updated set of accounts for a givenUserId
  void Function() listen(String userId, {AccountHandler onValue});
}
