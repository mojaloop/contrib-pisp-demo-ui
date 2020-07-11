import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/MockData/account.dart';
import 'package:pispapp/Screens/phone_number.dart';
import 'package:pispapp/theme/light_color.dart';
import 'package:pispapp/widgets/title_text.dart';

class NewPayment extends StatefulWidget {
  @override
  _NewPaymentState createState() => _NewPaymentState();
}

class _NewPaymentState extends State<NewPayment> {
  _NewPaymentState() {
    final List<Account> accounts = getMyDummyAccounts();
    _accounts = accounts
        .where(
          (Account element) => element.linked,
        )
        .toList();
    selectedAccount = _accounts[0];
  }

  List<Account> _accounts = <Account>[];
  Account selectedAccount;

  String phoneNumber;
  String phoneIsoCode;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(
      () {
        phoneNumber = number;
        phoneIsoCode = isoCode;
      },
    );
  }

  Widget _getStartedTile(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          // selectedAccount = acc;
        });
      },
      leading: Icon(Icons.search),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: 'Find Payee',
        fontSize: 14,
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  Widget _getAccountTile(BuildContext context, Account acc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedAccount = acc;
          });
        },
        leading: const CircleAvatar(),
        contentPadding: const EdgeInsets.symmetric(),
        title: TitleText(
          text: acc.alias,
          fontSize: 14,
        ),
        subtitle: Text(selectedAccount.accountNumber),
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
        _accounts.map((Account acc) => _getAccountTile(context, acc)).toList();

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(
              10,
              60,
              0,
              50,
            ),
            child: TitleText(
              text: 'Pay Now',
              fontSize: 20,
            ),
          ),
          // const TitleText(
          //   text: 'Choose an account',
          //   fontSize: 18,
          // ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: LightColor.navyBlue1),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xfff3f3f3),
                  offset: Offset(5, 5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const CircleAvatar(),
                  contentPadding: const EdgeInsets.symmetric(),
                  title: TitleText(
                    text: selectedAccount.alias,
                    fontSize: 18,
                  ),
                  subtitle: Text(
                    selectedAccount.accountNumber,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _showAccountChoosingBottomSheet();
                    },
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                ListTile(
                  leading: const TitleText(text: 'Balance'),
                  contentPadding: const EdgeInsets.symmetric(),
                  trailing: TitleText(
                    text: selectedAccount.balance,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.arrow_downward,
                  ),
                  Icon(
                    Icons.arrow_downward,
                  ),
                  Icon(
                    Icons.arrow_downward,
                  ),
                ],
              ),
              Container(
              width: 170.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 40.0,
                  height: 2.0,
                  color: LightColor.navyBlue2,
                ),
                onChanged: (String text) {
                  // amount = text;
                },
              ),
            ),
            ],
          ),

          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: LightColor.navyBlue1),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xfff3f3f3),
                  offset: Offset(5, 5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                _getStartedTile(context),
                PhoneNumberInput(
                  onPhoneNumberChange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
