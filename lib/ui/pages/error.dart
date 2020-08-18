import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  Error(this.errorString);
  factory Error.genericError() {
    const String message = 'Something went wrong';
    return Error(message);
  }

  final String errorString;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        errorString,
        style: const TextStyle(color: Colors.yellow),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
