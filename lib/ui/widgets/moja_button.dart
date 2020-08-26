import 'package:flutter/material.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:get/get.dart';

class MojaButton extends StatelessWidget {
  MojaButton(this.child, this.onTap);

  final Widget child;

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
            side: const BorderSide(color: Colors.blue),
          ),
          onPressed: onTap,
          color: LightColor.navyBlue1,
          textColor: Colors.white,
          child: child,
        ),
      ),
    );
  }
}
