import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/setup_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/phone_number_tile.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/phone_number.dart';

class PhoneNumberSetup extends StatelessWidget {
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
            const SizedBox(height: 20),
            GetBuilder<SetupController>(
              builder: (value) => ShadowBox(
                color:
                    value.phoneNumberPrompt ? Colors.red : LightColor.navyBlue1,
                child: Column(
                  children: <Widget>[
                    PhoneNumberTile(
                      trailingWidget: GetBuilder<SetupController>(
                          builder: (value) => value.correctPhoneNumber
                              ? Icon(
                                  Icons.check_circle_outline,
                                )
                              : const Text('')),
                    ),
                    PhoneNumberInput(
                      value.onPhoneNumberChange,
                      'Enter phone number',
                      Get.find<SetupController>().phoneNumber,
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
              TitleText(
                text: 'Login',
                color: Colors.white,
                fontSize: 20,
              ),
              () => Get.find<SetupController>().onLogin(),
            ),
          ],
        ),
      ),
    );
  }
}
