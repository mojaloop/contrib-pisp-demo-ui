import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pispapp/controllers/ephemeral/pin_entry_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class PinEntry extends StatelessWidget {
  // TODO: Refactor this button code after features are working
  Widget buildWidthFillingButton() {
    return SizedBox(
      width: double.infinity,
      child: buildSetPINButton(),
    );
  }

  // TODO: Factor this raised button into a new button and change button_button.dart
  Widget buildSetPINButton() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(
                color: Colors.blue,
              ),
            ),
            onPressed: () {
              PINEntryController p = Get.find<PINEntryController>();
              final String enteredPIN = p.textEditingController.text;
              if (enteredPIN.length == PINEntryController.PINlength) {
                final String enteredPIN = p.textEditingController.text;
                p.storeNewPIN(enteredPIN);
                p.textEditingController.clear();
              }
            },
            color: LightColor.navyBlue1,
            textColor: Colors.white,
            child: const TitleText(
                text: 'Set PIN', color: Colors.white, fontSize: 20)));
  }

  Widget buildPINEntryScreen(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<PINEntryController>(
                builder: (c) => c.userSetPIN
                    ? const Text('Please enter your PIN to resume using the app',
                        style: TextStyle(
                          fontSize: 18.0,
                        ))
                    : const Text('Please set your PIN',
                        style: TextStyle(
                          fontSize: 18.0,
                        )
                )
            ),
            const Icon(Icons.lock,
                size: 100, color: Colors.blue), // Replace with a nice image
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: PinCodeTextField(
                length: PINEntryController.PINlength,
                onCompleted: (value) {
                  Get.find<PINEntryController>().onPINEntered(value);
                },
                errorAnimationController:
                    Get.find<PINEntryController>().errorController,
                controller:
                    Get.find<PINEntryController>().textEditingController,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  // Box background
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  // Outline
                  activeColor: Colors.blue,
                  selectedColor: Colors.blue,
                  inactiveColor: Colors.grey,
                ),
                enableActiveFill: true,
                backgroundColor: Colors.transparent,
                textInputType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                // Allow only numbers
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 200),
              ),
            ),
            GetBuilder<PINEntryController>(
                builder: (c) => c.userSetPIN
                    ? Container(width: 0.0, height: 0.0)
                    : buildWidthFillingButton())
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Your Identity'),
          leading: const Icon(Icons.account_circle),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: buildPINEntryScreen(context),
        ));
  }
}
