import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(114, 208, 244, .1),
  100: const Color.fromRGBO(114, 208, 244, .2),
  200: const Color.fromRGBO(114, 208, 244, .3),
  300: const Color.fromRGBO(114, 208, 244, .4),
  400: const Color.fromRGBO(114, 208, 244, .5),
  500: const Color.fromRGBO(114, 208, 244, .6),
  600: const Color.fromRGBO(114, 208, 244, .7),
  700: const Color.fromRGBO(114, 208, 244, .8),
  800: const Color.fromRGBO(114, 208, 244, .9),
  900: const Color.fromRGBO(114, 208, 244, 1),
};

MaterialColor materialColor = MaterialColor(0xFF72d0f4, color);

class AppTheme {
  Color? bg1;
  Color? primary;
  Color? primaryLight;
  Color? surface;
  Color? accent1;
  Color? grey;
  Color? greyStrong;
  Color? greyWeak;
  Color? error;
  Color? focus;
  Color? txt;
  Color? accentTxt;

  static AppTheme of(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    if (isDarkMode) {
      return isDarkTheme();
    } else {
      return isLightTheme();
    }
  }

  static AppTheme theme(Brightness brightness) {
    bool isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return isDarkTheme();
    } else {
      return isLightTheme();
    }
  }

  static AppTheme isLightTheme() {
    return AppTheme()
      ..bg1 = const Color(0xFFf3f6fb)
      ..primary = const Color(0xFF72d0f4)
      ..primaryLight = Colors.blue
      ..surface = Colors.white
      ..greyWeak = const Color(0xffD8D8D8)
      ..grey = const Color(0xff737373)
      ..greyStrong = const Color(0xff515d5a)
      ..error = const Color(0xffFF1717)
      ..focus = const Color(0xFF0ee2b1)
      ..txt = Colors.black
      ..accentTxt = const Color(0xFF737373);
  }

  static AppTheme isDarkTheme() {
    return AppTheme()
      ..bg1 = const Color(0xff00120f)
      ..primary = const Color(0xFFe50914)
      ..surface = Colors.black
      ..greyWeak = const Color(0xffa8b3b0)
      ..grey = const Color(0xffa8b3b0)
      ..greyStrong = const Color(0xffffffff)
      ..error = const Color(0xffe55642)
      ..focus = const Color(0xff0ee2b1)
      ..txt = Colors.white
      ..accentTxt = Colors.white;
  }
}
