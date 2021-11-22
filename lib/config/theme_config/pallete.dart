import 'dart:math';

import 'package:flutter/material.dart';

class Palette {
  int dark = 0xff16213e;

  // for accent color
  // https://colorhunt.co/palette/faf3f3e1e5eaa7bbc7da7f8f
  // #FAF3F3
  //

  static const Color primary = Color(0xffcc343c);
  static const int primaryColor = 0xffcc343c;
  static const int accentColor11 = 0xffFB8A90;
  static const int accentColor21 = 0xffE55960;
  static const int accentColor31 = 0xffCC343C;
  static const int accentColorBeigeInt = 0xffFAF3F3;

  static const Color backgroundColor = Colors.white;
  static const Color backgroundColorDark = Colors.black38;
  static const Color accentColor1 = Color(accentColor11);
  static const Color accentColor2 = Color(accentColor21);
  static const Color accentColor3 = Color(accentColor31);
  static const Color accentColorBeige = Color(accentColorBeigeInt);

  // beige-shades
  // static const int primaryColor = 0xfffaf0e6;
  // static const int accentColor = 0xffd9b99b;

}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
