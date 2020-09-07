import 'package:flutter/material.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/data/transaction_ui_data.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/utils/utils.dart';

class TransactionTile extends StatelessWidget {
  TransactionTile(this._transaction, this._onTap)
      : _transactionUIData = TransactionUIData(_transaction);

  final Transaction _transaction;
  final void Function(Transaction) _onTap;

  final TransactionUIData _transactionUIData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _onTap(_transaction),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: _transactionUIData.textColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(_transactionUIData.iconData, color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(_transaction.payee.name ?? 'Unknown', fontSize: 14),
      subtitle: Text(
        _transaction.completedTimestamp != null
            ? Utils.getDateFromDateTime(
                DateTime.parse(_transaction.completedTimestamp).toLocal(),
              )
            : '',
      ),
    );
  }
}
