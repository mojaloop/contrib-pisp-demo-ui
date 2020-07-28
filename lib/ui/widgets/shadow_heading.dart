import 'package:flutter/material.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class ShadowBoxHeading extends StatelessWidget {
  ShadowBoxHeading(this.s);
  final String s;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: s,
        fontSize: 18,
      ),
    );
  }
}
