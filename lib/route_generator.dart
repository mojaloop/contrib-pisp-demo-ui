import 'package:flutter/material.dart';
import 'package:pispapp/Screens/dashboard.dart';

// To encapsulate logic around routing and route guards at one place
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final Object args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => Dashboard());
      case '/second':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute<dynamic>(
            builder: (_) => Dashboard(
                // data: args,
                ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'ERROR',
          ),
        ),
      );
    });
  }
}
