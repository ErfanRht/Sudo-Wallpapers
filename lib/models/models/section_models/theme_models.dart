import 'package:shared_preferences/shared_preferences.dart';

class ThemeModels {
  static Future<bool> setAppTheme(int themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('appTheme', themeMode);
    print(themeMode);
    return true;
  }

  static Future<int> getAppTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeMode = prefs.getInt("appTheme");
    // ignore: unused_local_variable
    int defaultThemeMode = 0;
    if (themeMode == null) {
      setAppTheme(defaultThemeMode);
      themeMode = defaultThemeMode;
    }
    return themeMode;
  }
}
