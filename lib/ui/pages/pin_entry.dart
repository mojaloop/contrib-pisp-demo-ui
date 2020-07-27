import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pispapp/controllers/ephemeral/user_pin_auth_controller.dart';


class PinEntry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PinEntryState();
}

class _PinEntryState extends State<PinEntry> {
  // Handles animation for error
  StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();

  // Handles text field
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your PIN'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Please enter your PIN to resume using the app',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              const Icon(Icons.lock,
              size: 100,
              color: Colors.blue), // Replace with a nice image
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: PinCodeTextField(
                  length: 6,
                  onCompleted: (value) {
                    textEditingController.clear();
                    print(Get.find<PINAuthController>().userSetPIN);
                    final bool correct = Get.find<PINAuthController>().authenticate(value);
                    if (correct) {
                      assert(Navigator.canPop(context));
                      Navigator.pop(context);
                    }
                    else {
                      errorController.add(ErrorAnimationType.shake);
                    }
                  },
                  errorAnimationController: errorController,
                  controller: textEditingController,
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
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                  enableActiveFill: true,
                  backgroundColor: Colors.transparent,
                  textInputType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly], // Allow only numbers
                  autoFocus: true,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 200),
                ),
              )
            ]),
      ),
    );
  }
}
