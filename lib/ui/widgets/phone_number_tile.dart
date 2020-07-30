import 'package:flutter/material.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PhoneNumberTile extends StatelessWidget {
  const PhoneNumberTile({Key key, this.trailingWidget}) : super(key: key);

  final Widget trailingWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: const TitleText(
        text: 'Find Payee',
        fontSize: 14,
      ),
      trailing: trailingWidget,
    );
  }
}