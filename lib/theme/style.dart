import 'package:flutter/material.dart';

class Style {
  static Color SecondaryColor = const Color(0xFF22A45D);
  static Color primaryColor = const Color(0xFF003172);
  static Color resturantTagColor = const Color(0xFF868686);
  static Color navBarSecondaryColor = const Color(0xFF979797);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static ThemeData themeData = ThemeData(
      textTheme: TextTheme(
          headline4: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)));
}
