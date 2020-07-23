import 'package:flutter/material.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

class ShadowBox extends StatelessWidget {
  ShadowBox({this.child, this.color = LightColor.navyBlue1});
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xfff3f3f3),
            offset: Offset(5, 5),
            blurRadius: 10,
          )
        ],
      ),
      child: child,
    );
  }
}
