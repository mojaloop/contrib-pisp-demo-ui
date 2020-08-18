import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/controllers/ephemeral/splash_controller.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            const SizedBox(height: 150.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'MojaPay',
                  style: GoogleFonts.muli(
                    fontSize: 55,
                    fontWeight: FontWeight.w600,
                    color: const Color(
                      0xff000000,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Transfer Money',
                  style: GoogleFonts.muli(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: const Color(
                      0xff76797e,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Simplifies and speeds up payments',
                  style: GoogleFonts.muli(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(
                      0xff76797e,
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            BottomButton(
              const TitleText(
                text: "Let's get started",
                color: Colors.white,
                fontSize: 20,
              ),
              () {
                Get.find<SplashController>().onButtonClick();
              },
            ),
          ],
        ),
      ),
    );
  }
}
