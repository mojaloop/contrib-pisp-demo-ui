import 'package:flutter/material.dart';
import 'moja_button.dart';

class BottomButton extends StatelessWidget {
  BottomButton(this.child, this.onTap);

  final Widget child;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomRight,
        child: MojaButton(child, onTap),
      ),
    );
  }
}
