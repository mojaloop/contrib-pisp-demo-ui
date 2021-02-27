import 'package:shared_preferences/shared_preferences.dart';

class KeyRepository {
  static const String KEY_HANDLE_KEY = 'KEY_HANDLE';

  static Future<String> loadKeyHandle(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key =
        prefs.getString('${KeyRepository.KEY_HANDLE_KEY}#$username');
    return key;
  }

  static Future<void> storeKeyHandle(String keyHandle, String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String k = '${KeyRepository.KEY_HANDLE_KEY}#$username';
    await prefs.setString(k, keyHandle);
  }

  static Future<void> removeAllKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys().forEach((key) => prefs.remove(key));
  }
}
