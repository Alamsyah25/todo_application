import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static late SharedPreferences _prefs;

  // add static const String for key shared preferences
  static const String _keyToken = '_keyToken';
  static const String _keyUser = '_keyUser';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setToken(String token) {
    _prefs.setString(_keyToken, token);
  }

  static String getToken() {
    return _prefs.getString(_keyToken) ?? '';
  }

  static String getUser() {
    return _prefs.getString(_keyUser) ?? '';
  }

  static void setUser(String user) {
    _prefs.setString(_keyUser, user);
  }
}
