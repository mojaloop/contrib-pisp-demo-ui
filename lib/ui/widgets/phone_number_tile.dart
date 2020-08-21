import 'package:flutter/material.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PhoneNumberTile extends StatelessWidget {
  const PhoneNumberTile({Key key, this.trailingWidget, this.heading})
      : super(key: key);

  final String heading;

  final Widget trailingWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        heading,
        fontSize: 14,
      ),
      trailing: trailingWidget,
    );
  }
}
