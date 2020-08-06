import 'package:flutter/material.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PhoneNumberTile extends StatelessWidget {
  const PhoneNumberTile({Key key, this.trailingWidget, this.text})
      : super(key: key);

  final Widget trailingWidget;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: text ?? 'Find payee',
        fontSize: 14,
      ),
      trailing: trailingWidget,
    );
  }
}
