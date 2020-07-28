import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class LookupPayee extends StatelessWidget {
  Widget _buildPayeeTile(Account account) {
    return ListTile(
      onTap: () {
        Get.find<LookupPayeeController>().onTapPayertile(account);
      },
      leading: const CircleAvatar(),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: account.name,
        fontSize: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<LookupPayeeController>(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 40, 0, 50),
                    child: TitleText(
                      text: 'Choose Payee',
                      fontSize: 20,
                    ),
                  ),
                  for (final Account acc in _.payeeAccounts)
                    _buildPayeeTile(acc),
                  if (_.payeeAccounts.isEmpty)
                    const TitleText(text: 'No Payee Accounts Found'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
