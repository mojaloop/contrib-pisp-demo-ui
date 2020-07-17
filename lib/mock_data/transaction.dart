enum Status { 
   SUCCESSFUL, PENDING, ERROR,
}
class Transaction {
  Transaction(this.from, this.to, this.amount, this.date, this.payeeName, this.status);

  String from, to, amount, date, payeeName;
  Status status;
  
}

List<Transaction> transactions = <Transaction>[
  Transaction(
    '120980988878828',
    '123123123',
    '100',
    '23 Feb 2020',
    'Mark Doe',
    Status.SUCCESSFUL,
  ),
  Transaction(
    '120980988878828',
    '123123123',
    '100',
    '23 Feb 2020',
    'Mark Doe',
    Status.PENDING,
  ),
  Transaction(
    '120980988878828',
    '123123123',
    '100',
    '15 Feb 2020',
    'Mark Doe',
    Status.ERROR,
  ),
  Transaction(
    '1231231',
    '120980988878828',
    '100',
    '10 Feb 2020',
    'John',
    Status.ERROR,
  ),
  Transaction(
    '120980988878821',
    '123123123',
    '100',
    '8 Feb 2020',
    'Mark Doe',
    Status.SUCCESSFUL,
  ),
  Transaction(
    '1231231',
    '120980988878821',
    '100',
    '2 Feb 2020',
    'John',
    Status.PENDING,
  ),
];

List<Transaction> getCreditTransactions(String accountId) {
  return transactions
      .where((Transaction element) => element.to == accountId)
      .toList();
}

List<Transaction> getDebitTransactions(String accountId) {
  return transactions
      .where((Transaction element) => element.from == accountId)
      .toList();
}
