import 'package:flutter/material.dart';
import 'moja_button.dart';

class BottomButton extends StatelessWidget {
  BottomButton(this.text, this.onTap);

  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomRight,
        child: MojaButton(text, onTap),
      )
      );
  }
}