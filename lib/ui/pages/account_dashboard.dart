import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account_dashboard_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/widgets/account_choosing_bottom_sheet.dart';
import 'package:pispapp/ui/widgets/account_dashboard_app_bar.dart';
import 'package:pispapp/ui/widgets/operations.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/ui/widgets/transaction_bottom_sheet.dart';
import 'package:pispapp/ui/widgets/transaction_tile.dart';

class AccountDashboard extends StatelessWidget {
  void _showTransactionDetailBottomSheet(Transaction t) {
    Get.bottomSheet<dynamic>(
      TransactionBottomSheet(t),
    );
  }

  void _showAccountChoosingBottomSheet() {
    Get.bottomSheet<void>(
      AccountChoosingBottomSheet(
        onTap: (Account acc) {
          Get.find<AccountDashboardController>().onAccountTileTap(acc);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          Get.find<AccountDashboardController>().onRefresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                AccountDashboardAppBar(() {
                  _showAccountChoosingBottomSheet();
                }),
                const SizedBox(
                  height: 50,
                ),
                const TitleText(
                  text: 'Operations',
                ),
                const SizedBox(
                  height: 10,
                ),
                Operations(),
                const SizedBox(
                  height: 40,
                ),
                const TitleText(
                  text: 'Transactions',
                ),
                GetBuilder<AccountDashboardController>(builder: (value) {
                  return Column(
                    children: value.transactionList
                        .map(
                          (Transaction t) => TransactionTile(
                            t,
                            (Transaction t) {
                              _showTransactionDetailBottomSheet(t);
                            },
                          ),
                        )
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
