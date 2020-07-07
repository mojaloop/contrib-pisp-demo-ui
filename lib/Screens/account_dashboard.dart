import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/MockData/account.dart';
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
  }

  Widget _appBar() {
    return Row(
      children: <Widget>[
        const CircleAvatar(),
        const SizedBox(width: 15),
        TitleText(text: accounts[0].alias),
        const Expanded(
          child: SizedBox(),
        ),
        Icon(
          Icons.short_text,
          color: Theme.of(context).iconTheme.color,
        )
      ],
    );
  }

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _icon(Icons.transfer_within_a_station, 'Transfer'),
        _icon(Icons.delete_sweep, 'Unlink'),
        _icon(Icons.code, 'Qr Pay'),
      ],
    );
  }

  Widget _icon(IconData icon, String text) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/transfer');
          },
          child: Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                const BoxShadow(
                    color: Color(0xfff3f3f3),
                    offset: Offset(5, 5),
                    blurRadius: 10)
              ],
            ),
            child: Icon(icon),
          ),
        ),
        Text(
          text,
          style: GoogleFonts.muli(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xff76797e),
          ),
        ),
      ],
    );
  }

  Widget _transactionList() {
    return Column(
      children: <Widget>[
        _transaction('Mark Doe', '23 Feb 2020', '20'),
        _transaction('John Doe', '25 Feb 2020', '20'),
        _transaction('Flight Ticket', '03 Mar 2020', '20'),
        _transaction('Flight Ticket', '03 Mar 2020', '-20'),
      ],
    );
  }

  Widget _transaction(String text, String time, String amount) {
    var icon = (amount[0] == '-')
        ? Icons.keyboard_arrow_right
        : Icons.keyboard_arrow_left;
    final color =
        (amount[0] != '-') ? const Color(0xff4caf50) : const Color(0xffd50000);

    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: text,
        fontSize: 14,
      ),
      subtitle: Text(time),
      trailing: Container(
        height: 30,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: LightColor.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          amount,
          style: GoogleFonts.muli(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: LightColor.navyBlue2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 35),
                _appBar(),
                const SizedBox(
                  height: 40,
                ),
                const TitleText(text: 'Details'),
                const SizedBox(
                  height: 20,
                ),
                BalanceCard(account: accounts[0]),
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
            )),
      ),
    );
  }
}
