import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/dashboard/account_dashboard_controller.dart';
import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/transaction.dart';
import 'package:pispapp/ui/widgets/account_choosing_bottom_sheet.dart';
import 'package:pispapp/ui/widgets/account_dashboard_app_bar.dart';
import 'package:pispapp/ui/widgets/operations.dart';
import 'package:pispapp/ui/widgets/title_text.dart';
import 'package:pispapp/ui/widgets/transaction_bottom_sheet.dart';
import 'package:pispapp/ui/widgets/transaction_tile.dart';

import '../theme/light_theme.dart';

class AccountDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountDashboardController>(builder: (controller) {
      if (controller.isLoading) {
        return _buildLoadingWidget();
      } else {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              print(
                  'AccountDashboard.build.onRefresh - doing nothing as this seems bad');
              // Get.find<AccountDashboardController>().refresh();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 30, 0, 30),
                      child: TitleText('Accounts', fontSize: 20),
                    ),
                    ..._buildMenuWidgets(controller),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildLoadingWidget() {
    return Scaffold(
      body: Container(
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(LightColor.lightBlue2),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenuWidgets(AccountDashboardController controller) {
    print('AccountList ' + controller.accountList.first.alias.toString());

    if (controller.accountList.isEmpty) {
      return <Widget>[
        const TitleText('No Accounts Linked', fontSize: 20),
      ];
    }

    return <Widget>[
      AccountDashboardAppBar(() {
        _showAccountChoosingBottomSheet();
      }),
      const SizedBox(height: 50),
      // TODO - LD removed for now
      // const TitleText('Operations'),
      // const SizedBox(height: 10),
      // Operations(),
      const SizedBox(height: 40),
      ..._buildTransfersSection(controller)
    ];
  }

  List<Widget> _buildTransfersSection(AccountDashboardController controller) {
    if (controller.transactionList.isEmpty) {
      return [
        const TitleText(
          'Transfers',
          fontSize: 20,
        ),
        const SizedBox(height: 40),
        const TitleText(
          'No transfers yet... select Transfer to get started.',
          textAlign: TextAlign.center,
          fontSize: 16,
          color: LightColor.grey,
        ),
      ];
    }

    return [
      const TitleText('Transfers'),
      ...controller.transactionList.map(
        (transaction) => TransactionTile(
          transaction,
          (t) => _showTransactionDetailBottomSheet(t),
        ),
      )
    ];
  }

  void _showTransactionDetailBottomSheet(Transaction t) {
    Get.bottomSheet<dynamic>(TransactionBottomSheet(t));
  }

  void _showAccountChoosingBottomSheet() {
    Get.bottomSheet<void>(
      AccountChoosingBottomSheet(
        onTap: (Account account) {
          Get.find<AccountDashboardController>().setSelectedAccount(account);
        },
      ),
    );
  }
}
