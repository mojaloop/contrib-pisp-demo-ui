import 'package:flutter/material.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class ShadowBoxHeading extends StatelessWidget {
  ShadowBoxHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text,
        fontSize: 18,
      ),
    );
  }
}
