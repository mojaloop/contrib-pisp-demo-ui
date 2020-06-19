import 'package:flutter/material.dart';
import 'route_generator.dart';
import 'Screens/phone_number.dart';
import 'Screens/Dashboard.dart';
import 'Screens/Error.dart';
import 'Screens/TransactionSuccess.dart';

void main() {
  print('starting app');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mojapay',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return buildError(context, errorDetails);
        };
        return widget;
      },
      // Initially display FirstPage
      home: Dashboard(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}




