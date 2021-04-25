import 'package:shared_preferences/shared_preferences.dart';

class LanguageModels {
  static Future<bool> setAppLanguage(String appLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('appLanguage', appLanguage);
    return true;
  }

  static Future<String> getAppLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String appLanguage = prefs.getString("appLanguage");
    String defaultLanguage = 'fa';
    if (appLanguage == null) {
      setAppLanguage(defaultLanguage);
      appLanguage = defaultLanguage;
    }
    return appLanguage;
  }
}
