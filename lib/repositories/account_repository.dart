import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

class AccountRepository implements IAccountRepository {
  final Firestore firestore = Firestore.instance;
  CollectionReference get accounts => firestore.collection('accounts');

  @override
  Future<List<Account>> getUserAccounts(String userId) async {
    final userAccounts = await accounts
        .where('userId', isEqualTo: userId)
        .where('linked', isEqualTo: true)
        .getDocuments();
    final List<Account> accountsList =
        userAccounts.documents.map((DocumentSnapshot element) {
      return Account.fromJson(element.data);
    }).toList();
    return accountsList;
  }
}
