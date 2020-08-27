import 'package:flutter/material.dart';
import 'package:pispapp/controllers/app/auth_controller.dart';
import 'package:pispapp/controllers/app/user_data_controller.dart';
import 'package:pispapp/controllers/ephemeral/profile_controller.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.user;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 0, 30),
              child: TitleText('Profile', fontSize: 20),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoUrl),
                  radius: 60,
                ),
              ),
            ),
            Center(child: TitleText(user.name)),
            const SizedBox(height: 40),
            Column(
              children: <Widget>[
                // _headingTile(context, 'Payee Details'),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(),
                  title: const TitleText('Email'),
                  trailing: Text(Get.find<AuthController>().user.email),
                ),
                GetBuilder<UserDataController>(builder: (value) =>
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(),
                    title: const TitleText(
                      'Phone Number',
                      fontSize: 18,
                    ),
                    trailing: Text(value.userInfo.getFormattedPhoneNoForDisplay()),
                  ),
                ),
                GetBuilder<UserDataController>(builder: (value) =>
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(),
                      title: const TitleText(
                        'Registration Date',
                        fontSize: 18,
                      ),
                      trailing: Text(value.userInfo.getFormattedRegistrationDateForDisplay()),
                    ),
                ),
              ],
            ),
            BottomButton(
              const TitleText(
                'Log out',
                color: Colors.white,
                fontSize: 20,
              ),
              onTap: () async {
                await Get.find<ProfileController>().onLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
