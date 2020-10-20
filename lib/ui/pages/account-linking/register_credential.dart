import 'dart:convert';
import 'dart:math';

import 'package:fido2_client/fido2_client.dart';
import 'package:fido2_client/registration_result.dart';
import 'package:fido2_example_app/key_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_api.dart';

class RegisterCredential extends StatefulWidget {
  RegisterCredential({Key key, this.loggedInUser}) : super(key: key);
  String loggedInUser;
  @override
  _FidoRegistrationState createState() => _FidoRegistrationState();
}

class _FidoRegistrationState extends State<RegisterCredential> {
  AuthApi _api = AuthApi();
  RegisterOptions _registerOptions;
  String status = 'Not started';

  get loggedInUser => widget.loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register credentials for $loggedInUser'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('REGISTRATION STATUS: $status'),
            RaisedButton(
                child: Text('Press to request registration options'),
                onPressed: () async {
                  setState(() {
                    status = 'Retrieving registration options...';
                  });
                  _registerOptions = await _api.registerRequest(loggedInUser);
                  setState(() {
                    status = 'Registration options retrieved';
                  });
                }),
            RaisedButton(
                child: Text('Press to register credentials'),
                onPressed: () async {
                  Fido2Client f = Fido2Client();
                  RegistrationResult r = await f.initiateRegistration(
                      _registerOptions.challenge,
                      _registerOptions.userId,
                      _registerOptions.username,
                      _registerOptions.rpId,
                      _registerOptions.rpName,
                      _registerOptions.algoId);
                  await KeyRepository.storeKeyHandle(r.keyHandle, loggedInUser);
                  User u = await _api.registerResponse(
                      loggedInUser,
                      _registerOptions.challenge,
                      r.keyHandle,
                      r.clientData,
                      r.attestationObj);
                  if (u.error == null) {
                    setState(() {
                      status = 'Success!';
                      Navigator.of(context).pop();
                    });
                  } else {
                    setState(() {
                      status = 'Error!';
                    });
                  }
                }),
          ],
        )));
  }
}
