import 'package:flutter/material.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:get/get.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class MojaButton extends StatelessWidget {
  MojaButton(this.text, this.onTap);

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ButtonTheme(
        minWidth: Get.width,
        height: 70.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
              color: Colors.blue,
            ),
          ),
          onPressed: onTap,
          color: LightColor.navyBlue1,
          textColor: Colors.white,
          child: TitleText(text: text, color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
