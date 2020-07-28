import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/login_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/phone_number.dart';

class Login extends StatelessWidget {
  Widget _loginWithGoogleTile() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: const TitleText(
        text: 'Link Google Account',
        fontSize: 14,
      ),
      trailing: GetBuilder<LoginController>(
        builder: (_) => _.googleLogin
            ? Icon(
                Icons.check_circle_outline,
              )
            : GestureDetector(
                onTap: () async {
                  await _.onLinkGoogleAccount();
                },
                child: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
      ),
    );
  }

  Widget _phoneNumberTile() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: const TitleText(
        text: 'Link Phone Number',
        fontSize: 14,
      ),
      trailing: GetBuilder<LoginController>(
          builder: (value) => value.correctPhoneNumber
              ? Icon(
                  Icons.check_circle_outline,
                )
              : const Text('')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 0, 30),
              child: TitleText(
                text: 'Mojapay Setup',
                fontSize: 20,
              ),
            ),
            GetBuilder<LoginController>(
              builder: (value) => ShadowBox(
                color: value.googleLoginPrompt ? Colors.red : LightColor.navyBlue1,
                child: Column(
                  children: <Widget>[
                    _loginWithGoogleTile(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GetBuilder<LoginController>(
              builder: (value) => ShadowBox(
                color: value.phoneNumberPrompt
                    ? Colors.red
                    : LightColor.navyBlue1,
                child: Column(
                  children: <Widget>[
                    _phoneNumberTile(),
                    PhoneNumberInput(
                      value.onPhoneNumberChange,
                      'Enter phone number',
                      Get.find<LoginController>().phoneNumber,
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
              'Login',
              () => Get.find<LoginController>().onLogin(),
            ),
          ],
        ),
      ),
    );
  }
}
