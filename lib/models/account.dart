import 'package:json_annotation/json_annotation.dart';

import 'model.dart';
part 'account.g.dart';

@JsonSerializable()
class Account implements Model {
  Account({
    String alias,
    String phoneNumber,
    String name,
    String balance,
    String accountNumber,
    String bankName,
    bool linked,
  })  : _alias = alias,
        _phoneNumber = phoneNumber,
        _name = name,
        _balance = balance,
        _accountNumber = accountNumber,
        _bankName = bankName,
        _linked = linked;

  @override
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  String _alias, _phoneNumber, _name, _balance, _accountNumber, _bankName;
  bool _linked = false;

  String get alias => _alias;

  String get phoneNumber => _phoneNumber;

  String get name => _name;

  String get balance => _balance;

  String get accountNumber => _accountNumber;

  String get bankName => _bankName;

  bool get linked => _linked;
}
