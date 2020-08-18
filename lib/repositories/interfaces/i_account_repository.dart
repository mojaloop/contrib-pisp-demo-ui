import 'package:pispapp/models/account.dart';

// Abstraction for methods related to read/write account information from external data sources
abstract class IAccountRepository {
  // TODO(StevenWjy): Add new methods here according to linking flow
  Future<List<Account>> getUserAccounts(String userId);
}
