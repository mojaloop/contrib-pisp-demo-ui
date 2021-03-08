import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/setup_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/login_google_tile.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class LoginSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 0, 30),
              child: TitleText(
                'Set up your PineapplePay Account',
                fontSize: 20,
              ),
            ),
            GetBuilder<SetupController>(
              builder: (value) => ShadowBox(
                color:
                    value.googleLoginPrompt ? Colors.red : LightColor.navyBlue1,
                child: Column(
                  children: <Widget>[
                    LoginWithGoogleTile(
                      onTap: () => value.onLinkGoogleAccount(),
                      trailingWidget: GetBuilder<SetupController>(
                        builder: (value) => value.googleLogin
                            ? const Icon(Icons.check_circle_outline,
                                color: Colors.green)
                            : GestureDetector(
                                child: const Icon(Icons.keyboard_arrow_right),
                                onTap: () => value.onLinkGoogleAccount(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<SetupController>().onTapNext();
        },
        tooltip: 'Continue setup',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
