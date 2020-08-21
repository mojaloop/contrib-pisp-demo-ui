import 'package:flutter/material.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/utils/utils.dart';

class TransactionTile extends StatelessWidget {
  TransactionTile(this._transaction, this._onTap)
      : _icon = _transaction.status == 'SUCCESS'
            ? Icons.check_circle_outline
            : (_transaction.status == 'ERROR'
                ? Icons.error_outline
                : Icons.hourglass_empty),
        _textColor = _transaction.status == 'SUCCESS'
            ? Colors.green
            : (_transaction.status == 'ERROR'
                ? Colors.red
                : LightColor.yellow2);
  final Transaction _transaction;
  final IconData _icon;
  final Color _textColor;
  final void Function(Transaction) _onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _onTap(_transaction);
      },
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: _textColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: Icon(_icon, color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(_transaction.payee.name, fontSize: 14),
      subtitle: Text(
        _transaction.completedTimestamp != null
            ? Utils.getDateFromDateTime(
                DateTime.parse(_transaction.completedTimestamp).toLocal())
            : '',
      ),
    );
  }
}
