import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'file:///C:/Users/Kenneth/Desktop/pisp-demo-app-flutter/lib/controllers/ephemeral/user_pin_auth_controller.dart';


class PinEntryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  // Handles animation for error
  StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();

  // Handles text field
  TextEditingController textEditingController = TextEditingController();

  // Handles business logic of PIN auth
  PINAuthController pinAuthController = PINAuthController();

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
              color: Colors.green), // Replace with a nice image
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: PinCodeTextField(
                  length: 6,
                  onCompleted: (value) {
                    final bool correct = pinAuthController.authenticate(value);
                    if (!correct) {
                      errorController.add(ErrorAnimationType.shake);
                      textEditingController.clear();
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
                    selectedColor: Colors.green,
                    inactiveColor: Colors.grey,
                  ),
                  enableActiveFill: true,
                  backgroundColor: Colors.transparent,
                  textInputType: TextInputType.number,
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
