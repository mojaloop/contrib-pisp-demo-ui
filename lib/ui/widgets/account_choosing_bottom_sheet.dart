import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/app/account_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/widgets/account_tile.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class AccountChoosingBottomSheet extends StatelessWidget {
  const AccountChoosingBottomSheet({Key key, this.onTap}) : super(key: key);

  final void Function(Account) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      color: const Color(0xFF737373),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: GetX<AccountController>(
          builder: (controller) {
            return ListView(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TitleText('Accounts'),
                ),
                const Divider(height: 20),
                ...controller.accounts.map(
                  (account) => AccountBottomSheetTile(
                    account,
                    onTap: () => onTap(account),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
