import 'package:pispapp/models/account.dart';

// Abstraction for methods related to read/write account information from external data sources
abstract class IAccountRepository {
  List<Account> getUserAccounts();
  List<Account> getPayeeAccountsByPhone(String phoneNumber);
}
