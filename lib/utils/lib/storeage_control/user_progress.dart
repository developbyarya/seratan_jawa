import 'package:shared_preferences/shared_preferences.dart';

class UserProgress {
  static Future<bool> getProgress(String day, String bagian) async {
    final pref = await SharedPreferences.getInstance();

    return pref.getBool("$day-$bagian") ?? false;
  }

  static Future<void> setProgress(String day, String bagian) async {
    final pref = await SharedPreferences.getInstance();

    await pref.setBool("$day-$bagian", true);
  }
}
