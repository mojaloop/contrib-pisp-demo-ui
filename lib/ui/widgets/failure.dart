import 'package:flutter/material.dart';

import 'title_text.dart';


class Failure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(height: 40),
          Icon(Icons.error_outline, size: 40),
          TitleText(
            text: 'Failure',
            color: Colors.red,
            fontSize: 28,
          ),
          SizedBox(height: 50),
        ],
      ),
    ));
  }
}
