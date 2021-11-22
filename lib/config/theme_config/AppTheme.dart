import 'package:flutter/material.dart';
import 'package:qrlens_community/config/theme_config/pallete.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData light = ThemeData(
    primaryColor: Palette.primary,
    primarySwatch: generateMaterialColor(Palette.primary),
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(color: Palette.primary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Palette.primary,
    ),
  );
  static final ThemeData dark = ThemeData(
    primaryColor: Palette.accentColorBeige,
    brightness: Brightness.dark,
    primarySwatch: generateMaterialColor(Palette.accentColorBeige),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(color: Palette.accentColorBeige),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Palette.accentColorBeige),
    // iconTheme: IconThemeData(
    //   color: Colors.white,
    // ),
  );
}
