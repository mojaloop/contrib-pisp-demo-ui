import 'package:flutter/material.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PayeeTile extends StatelessWidget {
  const PayeeTile({Key key, this.account, this.onTap}) : super(key: key);

  final Account account;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const CircleAvatar(),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: account.name,
        fontSize: 14,
      ),
    );
  }
}
