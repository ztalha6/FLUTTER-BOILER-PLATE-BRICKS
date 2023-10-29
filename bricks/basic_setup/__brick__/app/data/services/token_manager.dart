import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  late final SharedPreferences sharedPreferences;
  final String _jwtTokenKey = 'jwtTokenKey';
  final String _accesstokenKey = 'accesstokenKey';

  Future<String> getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(_jwtTokenKey)) {
      return sharedPreferences.getString(_jwtTokenKey)!;
    } else {
      return '';
    }
  }

  Future<bool> setToken(String token) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (token.isEmpty) {
      return false;
    }
    return sharedPreferences.setString(_jwtTokenKey, token);
  }

  Future<bool> clearToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(_jwtTokenKey);
  }

  Future<String> getAccessToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(_accesstokenKey)) {
      return sharedPreferences.getString(_accesstokenKey)!;
    } else {
      return '';
    }
  }

  Future<bool> setAccessToken(String token) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (token.isEmpty) {
      return false;
    }
    return sharedPreferences.setString(_accesstokenKey, token);
  }
}
