class Transaction {
  Transaction(this.from, this.to, this.amount);

  String from, to, amount;
}

List<Transaction> transactions = <Transaction>[
  Transaction('1231231', '123123123', '100', ),
  Transaction('1231231', '123123123', '100', ),
  Transaction('1231231', '123123123', '100', ),
  Transaction('1231231', '123123123', '100', ),
  Transaction('1231231', '123123123', '100', ),
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
