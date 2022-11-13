import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepo {
  static const String themeKey = "apptheme";
  static const String newUserKey = "newuser";

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

  /// saveNewUserValue(bool value)
  /// parameter: the bool to be saved
  /// returns: nothing
  Future<void> saveNewUserValue(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(newUserKey, value);
  }

  /// getNewUserValue()
  /// parameter: nothing
  /// returns: bool value from the key newUserKey if it returns null default to false
  Future<bool> getNewUserValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(newUserKey) ?? false;
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
