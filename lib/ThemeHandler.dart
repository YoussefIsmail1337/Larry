import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.light),
  );

  final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark),
  );

  bool _darktheme = false;

  bool getTheme() {
    return _darktheme;
  }

  void setTheme(bool _darkMode) {
    _darktheme = _darkMode;
    notifyListeners();
  }

  void toggleTheme() {
    _darktheme = !_darktheme;
    notifyListeners();
  }
}
