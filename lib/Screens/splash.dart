import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/theme/light_color.dart';

class SplashScreen extends StatelessWidget {
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
          onPressed: () {},
          color: LightColor.navyBlue1,
          textColor: Colors.white,
          child: Text(
            "Let's get started".toUpperCase(),
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
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 150.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                0,
                0,
              ),
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
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                0,
                0,
              ),
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
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                0,
                0,
              ),
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: _getStartedTile(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
