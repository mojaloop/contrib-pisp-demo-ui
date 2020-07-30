import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/ui/widgets/payee_tile.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class LookupPayee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<LookupPayeeController>(
            builder: (value) {
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
                  for (final Account acc in value.payeeAccounts)
                    PayeeTile(
                      account: acc,
                      onTap: () {
                        Get.find<LookupPayeeController>().onTapPayertile(acc);
                      },
                    ),
                  if (value.payeeAccounts.isEmpty)
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
