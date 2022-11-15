import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepo {
  static const String themeKey = "apptheme";
  static const String userKey = "user";

  /// saveThemeValue(int value)
  /// parameters: integer value that is to be stored
  /// returns: nothing
  Future<void> saveThemeValue(int optionValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(themeKey, optionValue);
  }

  /// getThemeValue()
  /// parameters: nothing
  /// returns: an integer that is stored on the themeKey
  /// if this functions is called and shared preference return null by default
  /// the function will return a 1 since dark mode is default theme
  Future<int> getThemeValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int option = preferences.getInt(themeKey) ?? 1;
    return option;
  }

  /// saveUserValue(String value)
  /// parameter: the bool to be saved
  /// returns: nothing
  Future<void> saveUserValue(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(userKey, value);
  }

  /// getUserValue()
  /// parameter: nothing
  Future<String?> getUserValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userKey);
  }

  /// destory()
  /// -Async function that clears all of the values stored in
  /// shared preferences
  /// - call this function during logout
  Future<void> destory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
