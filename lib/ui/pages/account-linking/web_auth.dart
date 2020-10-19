import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/web_auth_controller.dart';
import 'package:pispapp/controllers/flow/account_linking_flow_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/bottom_button.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class WebAuth extends StatelessWidget {
  WebAuth(this._accountLinkingFlowController);

  final AccountLinkingFlowController _accountLinkingFlowController;
  final WebAuthController _authController = WebAuthController();

  Widget _buildActionSection() {
    return GetBuilder<AccountLinkingFlowController>(
      init: _accountLinkingFlowController,
      global: false,
      builder: (controller) {
        if (!controller.isAwaitingUpdate) {
          // The user is only allowed to click the button once.
          // Afterward, the state of the payment flow controller will be updated
          // to be awaiting for response. Once the response is received, the
          // flow controller is expected to bring used to another page.
          return BottomButton(
            const TitleText(
              'Log in with financial service provider',
              color: Colors.white,
              fontSize: 15,
            ),
            onTap: () async {
              final String result = await FlutterWebAuth.authenticate(
                  url: controller.consent.authUri,
                  callbackUrlScheme: WebAuthController.customScheme);
              final String authToken =
                  _authController.extractAuthTokenFromResult(result);
              if (authToken != null) {
                _accountLinkingFlowController.sendAuthToken(authToken);
              }
              else {
                // TODO(kkzeng): Handle what happens when authToken is null
                // This means user has not been authenticated OR DFSP didn't
                // implement the scheme correctly
              }
            },
          );
        } else {
          // Once the user clicks the button, it will change to a circular progress
          // indicator until the mobile app receives the response from the server
          // which will include the payee information. The flow controller is
          // responsible to bring user to another screen that displays the payee
          // information.
          return BottomButton(
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }
      },
    );
  }

  Widget _buildAccountIcon() {
    return const Icon(
      Icons.account_circle,
      size: 120,
      color: LightColor.lightNavyBlue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Web Authentication'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildAccountIcon(),
              _buildActionSection(),
            ],
          ),
        ));
  }
}
