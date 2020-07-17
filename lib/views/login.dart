import 'package:flutter/material.dart';
import 'package:pispapp/mock_data/account.dart';
import 'package:pispapp/theme/light_color.dart';
import 'package:pispapp/utils/sign_in.dart';
import 'package:pispapp/views/phone_number.dart';
import 'package:pispapp/widgets/title_text.dart';

import 'account_dashboard.dart';
import 'dashboard.dart';
import 'lookup_payee.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            _signInButton(),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        String str = await signInWithGoogle();
        print(str);
        Navigator.of(context).push<dynamic>(
          MaterialPageRoute<dynamic>(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
      },

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class LoginPage1 extends StatefulWidget {
  @override
  _LoginPage1State createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  List<Account> _accounts = <Account>[];
  Account selectedAccount;

  String phoneNumber;
  String phoneIsoCode;
  bool showRightIcon = false;
  bool googleLogIn = false;

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
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: 'Link Phone Number',
        fontSize: 14,
      ),
      trailing: (showRightIcon ? GestureDetector(

        child: Icon(
          Icons.check_circle_outline,
          color: Theme.of(context).iconTheme.color,
        ),
      ) : Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).iconTheme.color,
      )),
    );
  }


  Widget _findPayeeWidget1(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          // selectedAccount = acc;
        });
      },
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: 'Link Google Account',
        fontSize: 14,
      ),
      trailing: (googleLogIn == false ? GestureDetector(
        onTap: () async {
          String str = await signInWithGoogle();
          print(str);
          setState(() {
            googleLogIn = true;
          });
        },
        child: Icon(
          Icons.keyboard_arrow_right,
          color: Theme.of(context).iconTheme.color,
        ),
      ) : GestureDetector(


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
          Icons.check_circle_outline,
          color: Theme.of(context).iconTheme.color,
        ),
      )),
    );
  }

  Widget _getStartedTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        height: 70.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: Colors.blue,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push<dynamic>(
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => Dashboard(),
              ),
            );
          },
          color: LightColor.navyBlue1,
          textColor: Colors.white,
          child: Text(
            "Login".toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(
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
              text: 'Mojapay Setup',
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

SizedBox(height: 20),
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
                _findPayeeWidget1(context),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _getStartedTile(context),
            ),
          ),
        ],

      ),
    ),);
  }
}

