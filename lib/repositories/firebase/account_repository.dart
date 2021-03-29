import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

class AccountRepository implements IAccountRepository {
  final Firestore firestore = Firestore.instance;
  CollectionReference get accounts => firestore.collection('accounts');

  @override
  Future<List<Account>> getUserAccounts(String userId) async {
    return accounts.where('userId', isEqualTo: userId).getDocuments().then(
          (snapshot) => snapshot.documents
              .map((element) => Account.fromJson(element.data))
              .toList(),
        );
  }

  @override
  void Function() listen(String userId, {AccountHandler onValue}) {
    final subscription =
        accounts.where('userId', isEqualTo: userId).snapshots().listen((event) {
      print('Listen: accounts updated!: ${event.documents.toString()}');
      // final accounts = Account.fromJson(event.document);
      // if (onValue != null) {
      //   onValue(transaction);
      // }
    });

    return () => subscription.cancel();
  }
}
