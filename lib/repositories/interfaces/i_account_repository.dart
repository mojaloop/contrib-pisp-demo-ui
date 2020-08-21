import 'package:pispapp/models/account.dart';

// Abstraction for methods related to read/write account information from external data sources
abstract class IAccountRepository {
  /// Returns list of accounts that are associated with a particular user.
  Future<List<Account>> getUserAccounts(String userId);
}
