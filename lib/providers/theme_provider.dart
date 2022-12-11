import 'package:flutter/material.dart';
import 'package:mytasks/theme/pallete.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = Pallete.lightModeAppTheme;

  ThemeData get theme => _theme;

  void toggleTheme() {
    _theme = _theme == Pallete.darkModeAppTheme
        ? Pallete.lightModeAppTheme
        : Pallete.darkModeAppTheme;

    Pallete.changedTheme = _theme == Pallete.darkModeAppTheme;
    notifyListeners();
  }
}
