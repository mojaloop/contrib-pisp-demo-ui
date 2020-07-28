import 'package:pispapp/models/account.dart';

abstract class IAccountRepository {
  List<Account> getUserAccounts();
  List<Account> getPayeeAccountsByPhone(String phoneNumber);
}
