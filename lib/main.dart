import 'package:flutter/material.dart';
import 'package:pispapp/views/dashboard.dart';
import 'package:pispapp/views/error.dart';
import 'package:pispapp/views/splash.dart';
import 'route_generator.dart';

void main() {
  print('starting app');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: 'Mojapay',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      builder: (
        BuildContext context,
        Widget widget,
      ) {
        ErrorWidget.builder = (
          FlutterErrorDetails errorDetails,
        ) {
          return Error.genericError();
        };
        return widget;
      },
      // Initially display FirstPage
      home: SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
