import 'package:flutter/material.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class AccountBottomSheetTile extends StatelessWidget {
  const AccountBottomSheetTile(this.account, {this.onTap});

  final Account account;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(),
        contentPadding: const EdgeInsets.symmetric(),
        title: TitleText(
          account.alias,
          fontSize: 14,
        ),
        subtitle: Text(account.fspInfo.fspName),
      ),
    );
  }
}
