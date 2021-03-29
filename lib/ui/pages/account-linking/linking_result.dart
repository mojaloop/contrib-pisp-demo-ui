import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/flow/account_linking_flow_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/routes/app_navigator.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/failure.dart';
import 'package:pispapp/ui/widgets/success.dart';
import 'package:pispapp/routes/app_routes.dart';

class LinkingResult extends StatelessWidget {
  LinkingResult(this._accountLinkingFlowController);

  final AccountLinkingFlowController _accountLinkingFlowController;

  @override
  Widget build(BuildContext context) {
    final consent = _accountLinkingFlowController.consent;
    final isSuccess = consent.status == ConsentStatus.active;

    // This screen is only intended to last for 3 seconds before it
    // moves to the main dashboard.
    Timer(const Duration(seconds: 3),
        () => Get.find<AppNavigator>().offAllNamed(Routes.DASHBOARD));

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                LightColor.navyBlue2,
                LightColor.lightBlue2,
              ],
            ),
          ),
          child: isSuccess ? Success() : Failure(),
        ),
      ),
    );
  }
}
