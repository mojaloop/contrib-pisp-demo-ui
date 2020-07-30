import 'package:flutter/material.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class TransactionTile extends StatelessWidget {
  TransactionTile(this._transaction, this._onTap)
      : _icon = _transaction.status == Status.SUCCESSFUL
            ? Icons.check_circle_outline
            : (_transaction.status == Status.PENDING
                ? Icons.hourglass_empty
                : Icons.error_outline),
        _textColor = _transaction.status == Status.SUCCESSFUL
            ? Colors.green
            : (_transaction.status == Status.PENDING
                ? LightColor.yellow2
                : Colors.red);
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
      title: TitleText(
        text: _transaction.payeeName,
        fontSize: 14,
      ),
      subtitle: Text(
        _transaction.date,
      ),
    );
  }
}
