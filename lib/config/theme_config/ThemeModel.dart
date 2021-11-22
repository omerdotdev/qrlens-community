import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  toggleTheme() {
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
      default:
        {
          mode = ThemeMode.system;
        }
        break;
    }
    return notifyListeners();
  }
}
