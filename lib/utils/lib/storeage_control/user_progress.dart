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

  static Future<double> getAllProgress(String day, int totalChater) async {
    final pref = await SharedPreferences.getInstance();
    int counter = 0;

    for (int i = 1; i <= totalChater; i++) {
      if (pref.getBool("$day-bagian$i") ?? false) {
        counter++;
      }
    }

    return counter / totalChater;
  }
}
