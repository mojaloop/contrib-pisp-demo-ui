import 'package:flutter/material.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PayeeTile extends StatelessWidget {
  const PayeeTile({Key key, this.payeeName, this.onTap}) : super(key: key);

  final String payeeName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const CircleAvatar(),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: payeeName,
        fontSize: 14,
      ),
    );
  }
}
