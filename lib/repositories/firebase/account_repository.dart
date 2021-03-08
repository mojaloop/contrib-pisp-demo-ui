import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

class AccountRepository implements IAccountRepository {
  final Firestore firestore = Firestore.instance;
  CollectionReference get accounts => firestore.collection('accounts');

  @override
  Future<List<Account>> getUserAccounts(String userId) async {
    print('AccountRepository getUserAccounts');
    print('AccountRepository getUserAccounts for userId: ' + userId);
    return accounts.where('userId', isEqualTo: userId).getDocuments().then(
          (snapshot) => snapshot.documents
              .map((element) => Account.fromJson(element.data))
              .toList(),
        );
  }
}
