import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/dashboard/account_dashboard_controller.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/data/transaction_ui_data.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/utils/utils.dart';

class TransactionBottomSheet extends StatelessWidget {
  TransactionBottomSheet(this._transaction)
      : _transactionUIData = TransactionUIData(_transaction);

  final Transaction _transaction;

  final TransactionUIData _transactionUIData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF737373),
      child: Wrap(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(_transactionUIData.iconData, size: 40),
                          const SizedBox(height: 20),
                          TitleText(
                            _transactionUIData.textData,
                            fontSize: 28,
                            color: _transactionUIData.textColor,
                          ),
                          const SizedBox(height: 20),
                          _buildTransactionAmountWidget()
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: GetBuilder<AccountDashboardController>(
                    builder: (value) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(),
                        title: const TitleText('From', fontSize: 14),
                        subtitle: Text(value.selectedAccount.fspInfo.name),
                        trailing: TitleText(
                          value.selectedAccount.alias,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(),
                    title: const TitleText('To', fontSize: 14),
                    subtitle: Text(
                      Utils.getSecretNumberFromString(
                          _transaction.payee.partyIdInfo.partyIdentifier),
                    ),
                    trailing: TitleText(_transaction.payee.name, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(),
                    title: const TitleText('Date', fontSize: 14),
                    trailing: TitleText(
                      _transaction.completedTimestamp ?? '',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionAmountWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        minWidth: Get.width * 0.6,
        height: 70.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.grey),
          ),
          onPressed: () {},
          color: LightColor.navyBlue2,
          textColor: Colors.white,
          child: Text(
            '${_transaction.amount.currency} ${_transaction.amount.amount}',
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
