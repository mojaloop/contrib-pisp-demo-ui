

import 'package:pispapp/models/account.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

List<Account> getMyDummyAccounts() {
  final List<Account> listOfAccounts = <Account>[];

  listOfAccounts.add(Account(
    alias: 'Personal',
    phoneNumber: 'IN1233323987',
    name: 'John Doe',
    balance: '100000',
    accountNumber: '120980988878828',
    bankName: 'Bank of India',
    linked: true,
  ));
  listOfAccounts.add(Account(
    alias: 'Business',
    phoneNumber: 'IN1233323987',
    name: 'John Doe1',
    balance: '1002340',
    accountNumber: '120980988878821',
    bankName: 'Axis Bank',
    linked: true,
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN1233323987',
    name: 'John Doe2',
    balance: '100000',
    accountNumber: '120980988878822',
    bankName: 'Bank of India',
    linked: false,
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN1233323987',
    name: 'John Doe3',
    balance: '100000',
    accountNumber: '120980988878823',
    bankName: 'Bank of India',
    linked: false,
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN1233323987',
    name: 'John Doe4',
    balance: '100000',
    accountNumber: '120980988878824',
    bankName: 'Bank of India',
    linked: false,
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN1233323987',
    name: 'John Doe5',
    balance: '100000',
    accountNumber: '120980988878825',
    bankName: 'Bank of India',
    linked: false,
  ));

  return listOfAccounts;
}

List<Account> getOtherDummyAccounts() {
  final List<Account> listOfAccounts = <Account>[];

  listOfAccounts.add(Account(
    phoneNumber: 'IN9999999999',
    name: 'Mark Doe',
    balance: '100000',
    accountNumber: '120980988878818',
    bankName: 'Bank of India',
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN9999999999',
    name: 'Mark Doe1',
    balance: '100000',
    accountNumber: '12098098887822',
    bankName: 'Bank of India',
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN1233323982',
    name: 'Mark Doe2',
    balance: '100000',
    accountNumber: '120980988878838',
    bankName: 'Bank of India',
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN1233323982',
    name: 'Mark Doe3',
    balance: '100000',
    accountNumber: '120980988878848',
    bankName: 'Bank of India',
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN1233323983',
    name: 'Mark Doe4',
    balance: '100000',
    accountNumber: '120980988878858',
    bankName: 'Bank of India',
  ));
  listOfAccounts.add(Account(
    phoneNumber: 'IN1233323983',
    name: 'Mark Doe5',
    balance: '100000',
    accountNumber: '120980988878868',
    bankName: 'Bank of India',
  ));

  return listOfAccounts;
}

List<Account> getOtherAccountsByPhone(String phone) {
  final List<Account> listOfAccounts = getOtherDummyAccounts();

  // filter based on phone number
  return listOfAccounts
      .where(
        (Account account) => account.phoneNumber == phone,
      )
      .toList();
}

class MockAccountRepository implements IAccountRepository {
  @override
  List<Account> getUserAccounts() {
    return getMyDummyAccounts().where(
          (Account element) => element.linked,
        )
        .toList();
  } 

  List<Account> getOtherAccounts() {
    return getOtherDummyAccounts();
  } 
}



