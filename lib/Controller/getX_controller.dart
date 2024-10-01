import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // Default theme is light
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
