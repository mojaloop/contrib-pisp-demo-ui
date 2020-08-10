import 'package:flutter/material.dart';

import '../theme/light_theme.dart';
import 'title_text.dart';

class Success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(height: 40),
          Icon(Icons.check_circle_outline, size: 40),
          TitleText(
            text: 'Successful',
            color: LightColor.yellow2,
            fontSize: 28,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
