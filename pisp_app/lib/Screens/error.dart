import 'package:flutter/material.dart';

Widget buildError(BuildContext context, FlutterErrorDetails error) {
  return const Error('Something went wrong');
}

class Error extends StatelessWidget {
  const Error(this.errorString);

  final String errorString;


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
