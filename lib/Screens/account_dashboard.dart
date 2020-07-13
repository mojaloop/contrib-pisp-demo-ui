import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/MockData/account.dart';
import 'package:pispapp/MockData/transaction.dart';
import 'package:pispapp/theme/light_color.dart';
import 'package:pispapp/widgets/balance_card.dart';
import 'package:pispapp/widgets/title_text.dart';

class AccountDashboard extends StatefulWidget {
  @override
  _AccountDashboardState createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  List<Account> accounts = <Account>[];
  Account account;

  @override
  void initState() {
    super.initState();

    accounts = getMyDummyAccounts();
    accounts = accounts
        .where(
          (Account element) => element.linked,
        )
        .toList();
    account = accounts[0];
  }

  Widget _getAccountTile(BuildContext context, Account acc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListTile(
        onTap: () {
          setState(() {
            account = acc;
          });
        },
        leading: const CircleAvatar(),
        contentPadding: const EdgeInsets.symmetric(),
        title: TitleText(
          text: acc.alias,
          fontSize: 14,
        ),
        subtitle: Text(acc.accountNumber),
        trailing: Container(
          height: 30,
          width: 60,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          child: Text(
            acc.balance,
            style: GoogleFonts.muli(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: LightColor.navyBlue2,
            ),
          ),
        ),
      ),
    );
  }

  void _showAccountChoosingBottomSheet() {
    final List<Widget> columnWidgets = [
      const Padding(
        padding: EdgeInsets.all(
          20.0,
        ),
        child: TitleText(text: 'Accounts'),
      ),
      const Divider(
        height: 20,
      ),
    ];
    final List<Widget> accountButtons =
        accounts.map((Account acc) => _getAccountTile(context, acc)).toList();

    columnWidgets.addAll(accountButtons);

    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
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
            child: ListView(
              children: columnWidgets,
            ),
          ),
        );
      },
    );
  }

  Widget _appBar() {
    return Row(
      children: <Widget>[
        const CircleAvatar(),
        const SizedBox(width: 15),
        TitleText(
          text: account.alias,
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
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _icon(
          Icons.transfer_within_a_station,
          'Transfer',
        ),
        _icon(
          Icons.delete_sweep,
          'Unlink',
        ),
        _icon(
          Icons.code,
          'Qr Pay',
        ),
      ],
    );
  }

  Widget _icon(IconData icon, String text) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xfff3f3f3),
                  offset: Offset(
                    5,
                    5,
                  ),
                  blurRadius: 10,
                )
              ],
            ),
            child: Icon(icon),
          ),
        ),
        Text(
          text,
          style: GoogleFonts.muli(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(
              0xff76797e,
            ),
          ),
        ),
      ],
    );
  }

  Widget _transactionList() {
    final List<Transaction> debitTransactionList =
        getDebitTransactions(account.accountNumber);
    return Column(
      children:
          debitTransactionList.map((Transaction t) => _transaction(t)).toList(),
    );
  }

  void _showTransactionDetailBottomSheet(Transaction t) {
    final IconData icon = t.status == Status.SUCCESSFUL
        ? Icons.check_circle_outline
        : (t.status == Status.PENDING ? Icons.assignment_late : Icons.cancel);
    final Color textColor = t.status == Status.SUCCESSFUL
        ? Colors.green
        : (t.status == Status.PENDING ? Colors.yellow : Colors.red);
    final String text = t.status == Status.SUCCESSFUL
        ? 'Successful'
        : (t.status == Status.PENDING ? 'Pending' : 'Error');
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
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
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.6,
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
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(),
                        title: const TitleText(
                          text: 'From',
                          fontSize: 14,
                        ),
                        subtitle: Text(account.accountNumber),
                        trailing: TitleText(
                          text: account.name,
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
                          text: 'To',
                          fontSize: 14,
                        ),
                        subtitle: Text(
                          t.to,
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
                        // subtitle: Text(account.accountNumber),
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
        );
      },
    );
  }

  Widget _transaction(Transaction t) {
    final icon = Icons.keyboard_arrow_right;
    const color = Color(0xffd50000);

    return ListTile(
      onTap: () {
        _showTransactionDetailBottomSheet(t);
      },
      leading: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          color: color,
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
      trailing: Container(
        height: 30,
        width: 60,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: LightColor.lightGrey,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: Text(
          t.amount,
          style: GoogleFonts.muli(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: LightColor.navyBlue2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                height: 40,
              ),
              const TitleText(text: 'Details'),
              const SizedBox(
                height: 20,
              ),
              BalanceCard(
                account: account,
              ),
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
              _transactionList(),
            ],
          ),
        ),
      ),
    );
  }
}
