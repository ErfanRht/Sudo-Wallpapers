import 'package:shared_preferences/shared_preferences.dart';

class ModeModels {
  static Future<bool> setAppMode(String appMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('appMode', appMode);
    return true;
  }

  static Future<String> getAppMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String appMode = prefs.getString("appMode");
    if (appMode == null) {
      setAppMode('default');
      appMode = 'firstEntery';
    }
    return appMode;
  }
}
