import 'package:flutter/material.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MojaButton extends StatelessWidget {
  MojaButton(this.child, {this.onTap});

  final Widget child;

  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
      child: ButtonTheme(
        minWidth: Get.width,
        height: 70.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
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
