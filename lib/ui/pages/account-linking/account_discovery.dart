import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/account_discovery_controller.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/available_fsp_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/moja_button.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class AccountDiscovery extends StatelessWidget {
  AccountDiscovery(this.fspId, this.fspName);

  final String fspId;
  final String fspName;
  final AccountDiscoveryController _controller = AccountDiscoveryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(fspName),
        ),
        body: Column(
          children: [
            const Text('Enter the ID of the account you are trying to link.'),
            TextField(
                textAlign: TextAlign.left,
                decoration: const InputDecoration(hintText: 'Account ID'),
                style: const TextStyle(
                  fontSize: 10.0,
                  height: 2.0,
                  color: LightColor.navyBlue2,
                ),
                onChanged: (String value) {
                  _controller.onIDChange(value);
                }),
            MojaButton(
                const TitleText(
                  'Confirm',
                  color: Colors.white,
                  fontSize: 20,
                ),
                    () => _controller.initiateLookup(fspId),
            ),
          ],
        ));
  }
}
