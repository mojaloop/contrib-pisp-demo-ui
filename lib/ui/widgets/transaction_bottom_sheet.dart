import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/utils/utils.dart';

class TransactionBottomSheet extends StatelessWidget {
  TransactionBottomSheet(this._transaction)
      : _icon = _transaction.status == Status.SUCCESSFUL
            ? Icons.check_circle_outline
            : (_transaction.status == Status.PENDING
                ? Icons.hourglass_empty
                : Icons.error_outline),
        _textColor = _transaction.status == Status.SUCCESSFUL
            ? Colors.green
            : (_transaction.status == Status.PENDING
                ? LightColor.yellow2
                : Colors.red),
        _text = _transaction.status == Status.SUCCESSFUL
            ? 'Successful'
            : (_transaction.status == Status.PENDING ? 'Pending' : 'Error');

  final IconData _icon;
  final Color _textColor;
  final String _text;
  final Transaction _transaction;

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
                topLeft: Radius.circular(
                  20.0,
                ),
                topRight: Radius.circular(
                  20.0,
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(
                            _icon,
                            size: 40,
                          ),
                          const SizedBox(height: 20),
                          TitleText(
                            text: _text,
                            fontSize: 28,
                            color: _textColor,
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(
                              8.0,
                            ),
                            child: ButtonTheme(
                              minWidth: Get.width * 0.6,
                              height: 70.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    18.0,
                                  ),
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: () {},
                                color: LightColor.navyBlue2,
                                textColor: Colors.white,
                                child: Text(
                                  '${_transaction.amount} \$',
                                  style: const TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: GetBuilder<AccountDashboardController>(
                    builder: (value) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(),
                        title: const TitleText(
                          text: 'From',
                          fontSize: 14,
                        ),
                        subtitle: Text(Utils.getSecretAccountNumberFromString(
                            value.selectedAccount.accountNumber)),
                        trailing: TitleText(
                          text: value.selectedAccount.name,
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
                    title: const TitleText(
                      text: 'To',
                      fontSize: 14,
                    ),
                    subtitle: Text(
                      Utils.getSecretAccountNumberFromString(_transaction.to),
                    ),
                    trailing: TitleText(
                      text: _transaction.payeeName,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(),
                    title: const TitleText(
                      text: 'Date',
                      fontSize: 14,
                    ),
                    trailing: TitleText(
                      text: _transaction.date,
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
}
