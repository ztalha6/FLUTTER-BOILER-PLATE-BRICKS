import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  late final SharedPreferences sharedPreferences;
  final String jwtTokenKey = 'jwtTokenKey';

  Future<String> getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(jwtTokenKey)) {
      return sharedPreferences.getString(jwtTokenKey)!;
    } else {
      return '';
    }
  }

  Future<bool> setToken(String token) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (token.isEmpty) {
      return false;
    }
    return await sharedPreferences.setString(jwtTokenKey, token);
  }
}
