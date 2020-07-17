import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/mock_data/account.dart';
import 'package:pispapp/views/phone_number.dart';
import 'package:pispapp/theme/light_color.dart';
import 'package:pispapp/widgets/title_text.dart';

import 'lookup_payee.dart';

class PaymentStart extends StatefulWidget {
  @override
  _PaymentStartState createState() => _PaymentStartState();
}

class _PaymentStartState extends State<PaymentStart> {
  List<Account> _accounts = <Account>[];
  Account selectedAccount;

  String phoneNumber;
  String phoneIsoCode;
  bool showRightIcon = false;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(
      () {
        phoneNumber = number;
        phoneIsoCode = isoCode;
      },
    );
    if(phoneNumber.length == 10) {
      setState(() {
        showRightIcon = true;
      });
    }
    else {
      setState(() {
        showRightIcon = false;
      });
    }
  }

  Widget _findPayeeWidget(BuildContext context) {
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
      trailing: (showRightIcon ? GestureDetector(
        onTap: () {
//          _showAccountChoosingBottomSheet();
          Navigator.of(context).push<dynamic>(
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => LookupPayee(
                phoneIsoCode,
                phoneNumber,
              ),
            ),
          );
        },
        child: Icon(
          Icons.keyboard_arrow_right,
          color: Theme.of(context).iconTheme.color,
        ),
      ) : null),
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
              30,
            ),
            child: TitleText(
              text: 'Pay Now',
              fontSize: 20,
            ),
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
                _findPayeeWidget(context),
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
