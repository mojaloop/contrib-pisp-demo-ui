import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pispapp/controllers/ephemeral/pin_entry_controller.dart';
import 'package:pispapp/ui/widgets/moja_button.dart';
import 'package:pispapp/utils/log_printer.dart';

class PinEntry extends StatelessWidget {
  // Handles animation for error
  // Must be created within the widget since a new stream should be created to avoid
  // "Stream has already been listened to" error
  StreamController<ErrorAnimationType> _errorController =
      StreamController<ErrorAnimationType>();

  // Handles text field
  TextEditingController _textEditingController = TextEditingController();

  PINEntryController _pinEntryController = Get.find<PINEntryController>();

  Widget buildWidthFillingButton() {
    return SizedBox(
        width: double.infinity,
        child: MojaButton('Set PIN', () {
          final String enteredPIN = _textEditingController.text;
          getLogger('PinEntry').i('User entered PIN');
          if (enteredPIN.length == PINEntryController.PINlength) {
            _pinEntryController.storeNewPIN(enteredPIN);
            _textEditingController.clear();
          }
        }),
    );
  }

  Widget buildPINEntryScreen(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width - 50,
            child: GetBuilder<PINEntryController>(
                builder: (c) => c.userSetPIN
                    ? const Text(
                        'Please enter your PIN to resume using the app.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      )
                    : const Text(
                        'Please set a PIN to be used in the future for verification purposes.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
            ),
          ),
          const Icon(Icons.lock,
              size: 100, color: Colors.blue), // Replace with a nice image
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: PinCodeTextField(
              length: PINEntryController.PINlength,
              onCompleted: (value) {
                // Only validate PIN when the user has set a PIN,
                // otherwise the user is able to save the PIN using
                // the save button.
                if (_pinEntryController.userSetPIN) {
                  _pinEntryController.onPINEntered(value, _textEditingController, _errorController);
                }
              },
              errorAnimationController: _errorController,
              controller: _textEditingController,
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
              autoDisposeControllers: true,
            ),
          ),
          GetBuilder<PINEntryController>(
              builder: (c) => c.userSetPIN
                  ? Container(width: 0.0, height: 0.0)
                  : buildWidthFillingButton())
        ],
      ),
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
        ),
    );
  }
}
