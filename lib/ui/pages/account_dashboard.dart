import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/icon.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/utils/utils.dart';

class AccountDashboard extends StatelessWidget {
  Widget _getAccountTile(Account acc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListTile(
        onTap: () {
          Get.find<AccountDashboardController>().onAccountTileTap(acc);
        },
        leading: const CircleAvatar(),
        contentPadding: const EdgeInsets.symmetric(),
        title: TitleText(
          text: acc.alias,
          fontSize: 14,
        ),
        subtitle: Text(Utils.getSecretAccountNumber(acc)),
      ),
    );
  }

  void _showAccountChoosingBottomSheet() {
    Get.bottomSheet<void>(
      Container(
        height: 350.0,
        color: const Color(0xFF737373),
        child: Container(
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
          child: GetX<AccountController>(
            builder: (value) {
              return ListView(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(
                      20.0,
                    ),
                    child: TitleText(text: 'Accounts'),
                  ),
                  const Divider(
                    height: 20,
                  ),
                  for (var acc in value.accounts.value) _getAccountTile(acc)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: <Widget>[
        const CircleAvatar(),
        const SizedBox(width: 15),
        GetBuilder<AccountDashboardController>(
          builder: (_) {
            return TitleText(text: _.selectedAccount.alias);
          },
        ),
        const Expanded(
          child: SizedBox(),
        ),
        GestureDetector(
          onTap: () {
            _showAccountChoosingBottomSheet();
          },
          child: Icon(
            Icons.short_text,
          ),
        ),
      ],
    );
  }

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomIcon(Icons.delete_sweep, 'Unlink', () {}),
        CustomIcon(Icons.code, 'Qr Pay', () {}),
      ],
    );
  }

  void _showTransactionDetailBottomSheet(Transaction t) {
    final IconData icon = t.status == Status.SUCCESSFUL
        ? Icons.check_circle_outline
        : (t.status == Status.PENDING
            ? Icons.hourglass_empty
            : Icons.error_outline);
    final Color textColor = t.status == Status.SUCCESSFUL
        ? Colors.green
        : (t.status == Status.PENDING ? LightColor.yellow2 : Colors.red);
    final String text = t.status == Status.SUCCESSFUL
        ? 'Successful'
        : (t.status == Status.PENDING ? 'Pending' : 'Error');
    Get.bottomSheet<dynamic>(Container(
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
                            icon,
                            size: 40,
                          ),
                          const SizedBox(height: 20),
                          TitleText(
                            text: text,
                            fontSize: 28,
                            color: textColor,
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
                                  '${t.amount} \$',
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
                  padding: const EdgeInsets.fromLTRB(
                    20.0,
                    0,
                    20,
                    0,
                  ),
                  child: GetBuilder<AccountDashboardController>(
                    builder: (_) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(),
                        title: const TitleText(
                          text: 'From',
                          fontSize: 14,
                        ),
                        subtitle: Text(
                            Utils.getSecretAccountNumber(_.selectedAccount)),
                        trailing: TitleText(
                          text: _.selectedAccount.name,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20.0,
                    0,
                    20,
                    0,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(),
                    title: const TitleText(
                      text: 'To',
                      fontSize: 14,
                    ),
                    subtitle: Text(
                      Utils.getSecretAccountNumberFromString(t.to),
                    ),
                    trailing: TitleText(
                      text: t.payeeName,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20.0,
                    0,
                    20,
                    0,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(),
                    title: const TitleText(
                      text: 'Date',
                      fontSize: 14,
                    ),
                    // subtitle: Text(selectedAccount.accountNumber),
                    trailing: TitleText(
                      text: t.date,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _transaction(Transaction t) {
    final IconData icon = t.status == Status.SUCCESSFUL
        ? Icons.check_circle_outline
        : (t.status == Status.PENDING
            ? Icons.hourglass_empty
            : Icons.error_outline);
    final Color textColor = t.status == Status.SUCCESSFUL
        ? Colors.green
        : (t.status == Status.PENDING ? LightColor.yellow2 : Colors.red);

    return ListTile(
      onTap: () {
        _showTransactionDetailBottomSheet(t);
      },
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: t.payeeName,
        fontSize: 14,
      ),
      subtitle: Text(
        t.date,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 35,
              ),
              _appBar(),
              const SizedBox(
                height: 50,
              ),
              const TitleText(
                text: 'Operations',
              ),
              const SizedBox(
                height: 10,
              ),
              _operationsWidget(),
              const SizedBox(
                height: 40,
              ),
              const TitleText(
                text: 'Transactions',
              ),
              GetBuilder<AccountDashboardController>(builder: (value) {
                return Column(
                  children: value.transactionList
                      .map((Transaction t) => _transaction(t))
                      .toList(),
                );
              }),
            ],
          ),
        ),
      ),
    ));
  }
}
