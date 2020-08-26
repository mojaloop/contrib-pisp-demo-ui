import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:pispapp/controllers/ephemeral/pin_entry_controller.dart';

class SecureStorage {
  // Constants - allows for more extensibility to store other keys
  static const String local_auth_pin_key = 'USER_PIN';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> _write({
    @required String key,
    @required String value,
    Duration timeoutDuration,
  }) async {
    bool timeout = false;
    await Future.any([
      _storage.write(key: key, value: value),
      Future.delayed(timeoutDuration, () {
        timeout = true;
      }),
    ]);

    if (timeout) {
      throw TimeoutException('Operation to store the user PIN timed out!');
    }
  }

  Future<String> _read({
    @required String key,
    Duration timeoutDuration = const Duration(milliseconds: 2000),
  }) async {
    final String pin = await Future.any([
      _storage.read(key: key),
      Future.delayed(timeoutDuration, () {
        return null;
      }),
    ]);
    return pin;
  }

  Future<String> readUserPIN() {
    return _read(
      key: local_auth_pin_key,
      timeoutDuration: PINEntryController.timeoutDuration,
    );
  }

  Future<void> writeUserPIN(String pin) {
    return _write(
      key: local_auth_pin_key,
      value: pin,
      timeoutDuration: PINEntryController.timeoutDuration,
    );
  }
}
