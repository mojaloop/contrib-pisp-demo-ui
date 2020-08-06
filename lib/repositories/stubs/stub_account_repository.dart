import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/fsp_info.dart';
import 'package:pispapp/models/party_id_info.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

final List<Account> accounts = <Account>[
  Account(
    alias: 'Personal',
    partyInfo: PartyIdInfo(
      fspId: 'DJCICFQ1919',
      partyIdentifier: 'IN1233323987',
    ),
    fspInfo: FspInfo(fspId: 'DJCICFQ1919', fspName: 'Bank of India'),
    consentId: '555',
    userId: 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
    sourceAccountId: 'bob.fspA',
  ),
  Account(
    alias: 'Business',
    partyInfo: PartyIdInfo(
      fspId: 'AJCICFQ1919',
      partyIdentifier: 'IN1233323987',
    ),
    fspInfo: FspInfo(fspId: 'AJCICFQ1919', fspName: 'Axis Bank'),
    consentId: '985',
    userId: 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
    sourceAccountId: 'bob.fspB',
  ),
];

class StubAccountRepository implements IAccountRepository {
  @override
  Future<List<Account>> getUserAccounts(String userId) {
    // final logger = getLogger('here');
    // logger.e('stub');
    return Future.value(accounts.toList());
  }
}
