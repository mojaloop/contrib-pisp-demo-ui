import 'package:flutter/material.dart';

Widget buildError(BuildContext context, FlutterErrorDetails error) {
  return Error('Something went wrong');
}

class Error extends StatelessWidget {
  final String errorString;

  const Error(this.errorString);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        errorString,
        style: TextStyle(color: Colors.yellow),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
