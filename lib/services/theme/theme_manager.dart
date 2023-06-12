import 'package:flutter/material.dart';

import 'theme_constants.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  ThemeData theme = lightTheme;

  toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
