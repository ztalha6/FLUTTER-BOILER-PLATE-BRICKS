import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  final String _firstStartKey = 'firstStart';

  Future<void> setFirstStart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstStartKey, true);
  }

  Future<bool> getFirstStart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstStartKey) ?? false;
  }
}
