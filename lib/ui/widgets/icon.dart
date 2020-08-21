import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomIcon extends StatelessWidget {
  CustomIcon(this.icon, this.text, {this.onTap});

  final IconData icon;

  final String text;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xfff3f3f3),
                  offset: Offset(5, 5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Icon(icon),
          ),
        ),
        Text(
          text,
          style: GoogleFonts.muli(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xff76797e),
          ),
        ),
      ],
    );
  }
}
