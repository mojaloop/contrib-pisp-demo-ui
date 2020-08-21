import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class AccountDashboardAppBar extends StatelessWidget {
  const AccountDashboardAppBar(this._onTap);

  final void Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const CircleAvatar(),
        const SizedBox(width: 15),
        GetBuilder<AccountDashboardController>(
          builder: (value) {
            return TitleText(value.selectedAccount.alias);
          },
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: _onTap,
          child: const Icon(Icons.short_text),
        ),
      ],
    );
  }
}
