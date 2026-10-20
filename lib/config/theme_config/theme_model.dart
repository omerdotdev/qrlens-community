import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  void toggleTheme() {
    switch (mode) {
      case ThemeMode.light:
        {
          mode = ThemeMode.dark;
        }
        break;
      case ThemeMode.dark:
        {
          mode = ThemeMode.system;
        }
        break;
      case ThemeMode.system:
        {
          mode = ThemeMode.light;
        }
        break;
    }
    return notifyListeners();
  }
}
