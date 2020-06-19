class Transaction {
  String from, to, amount;
  Transaction(this.from, this.to, this.amount);
}

List<Transaction> transactions = [
  Transaction("1231231", "123123123", "100"),
  Transaction("1231231", "123123123", "100"),
  Transaction("1231231", "123123123", "100"),
  Transaction("1231231", "123123123", "100"),
  Transaction("1231231", "123123123", "100"),

];

List<Transaction> getCreditTransactions(String accountId) {
  return transactions.where((element) => (element.to == accountId));
}

List<Transaction> getDebitTransactions(String accountId) {
  return transactions.where((element) => (element.from == accountId));
}