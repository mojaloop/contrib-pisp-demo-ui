import 'package:flutter/material.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/ephemeral/profile_controller.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
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
                text: 'Profile',
                fontSize: 20,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(Get.find<AuthController>().user.photoUrl),
                  radius: 60,
                ),
              ),
            ),
            Center(
              child:
                  TitleText(text: Get.find<AuthController>().user.displayName),
            ),
            const SizedBox(height: 40),
            Column(
              children: <Widget>[
                // _headingTile(context, 'Payee Details'),

                ListTile(
                  contentPadding: const EdgeInsets.symmetric(),
                  title: const TitleText(text: 'Email'),
                  trailing: Text(Get.find<AuthController>().user.email),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(),
                  title: const TitleText(
                    text: 'Phone Number',
                    fontSize: 18,
                  ),
                  trailing: Text(Get.find<AuthController>().phoneIsoCode +
                      Get.find<AuthController>().phoneNumber),
                ),
              ],
            ),
            BottomButton(
              const TitleText(
                text: 'Log out',
                color: Colors.white,
                fontSize: 20,
              ),
              () async {
                await Get.find<ProfileController>().onLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
