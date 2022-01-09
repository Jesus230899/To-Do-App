import 'package:flutter/material.dart';

class AppColors {
  // static const primaryColor = Color(0xff3b4663);
  static Color accentColor = Colors.blue[900];
  static const primaryColor = Color(0xfff7f7f7);
}

final theme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: AppColors.primaryColor,
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: AppColors.accentColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme:
        ThemeData().colorScheme.copyWith(primary: AppColors.primaryColor),
    splashColor: Colors.white,
    textTheme: const TextTheme(
      bodyText1: TextStyle(fontSize: 15),
      bodyText2: TextStyle(fontSize: 15),
      caption: TextStyle(fontSize: 15),
      button: TextStyle(fontSize: 15),
      headline4: TextStyle(fontSize: 15),
      headline1: TextStyle(fontSize: 15),
      headline5: TextStyle(fontSize: 15),
      headline6: TextStyle(fontSize: 15),
      overline: TextStyle(fontSize: 15),
      headline3: TextStyle(fontSize: 15),
      headline2: TextStyle(fontSize: 15),
      subtitle1: TextStyle(fontSize: 15),
      subtitle2: TextStyle(fontSize: 15),
    ));
