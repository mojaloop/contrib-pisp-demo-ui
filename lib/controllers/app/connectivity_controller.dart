import 'dart:async';

import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/ui/theme/light_theme.dart';

class ConnectivityController extends GetxController {
  bool isDialogShowing = false;

  // Note: Connectivity checks connection to google.com, may not be available
  // in countries that ban google such as China
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<bool> _subscription;

  Future<void> _showNoConnectionDialog() async {
    if (isDialogShowing) {
      return;
    }

    // Set dialog is showing to true
    isDialogShowing = true;

    await Get.defaultDialog<dynamic>(
      title: 'No internet connection',
      textCancel: 'Dismiss',
      cancelTextColor: LightColor.navyBlue1,
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: const [
          Icon(Icons.access_time, size: 80, color: LightColor.lightBlue1),
          SizedBox(height: 10),
          Text(
            'Please make sure you turn on your Wifi or Cellular Data!',
            style: TextStyle(color: LightColor.navyBlue1),
          ),
        ]),
      ),
    );

    // Set dialog showing to false after dismissed
    isDialogShowing = false;
  }

  void startListenForConnectionStatus() {
    _subscription = _connectivity.isConnected.listen((connected) {
      if (!connected) {
        // Show a screen
        _showNoConnectionDialog();
      }
    });
  }

  void stopListeningForConnectionStatus() {
    _subscription.cancel();
  }
}
