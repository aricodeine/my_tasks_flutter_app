import 'package:flutter/material.dart';
import 'package:mytasks/theme/pallete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = Pallete.lightModeAppTheme;

  ThemeData get theme => _theme;

  ThemeProvider({required bool isDark}) {
    Pallete.changedTheme = isDark;
    _theme = isDark ? Pallete.darkModeAppTheme : Pallete.lightModeAppTheme;
  }

  Future<void> toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_theme == Pallete.darkModeAppTheme) {
      _theme = Pallete.lightModeAppTheme;
      await prefs.setBool('isDark', false);
      Pallete.changedTheme = false;
    } else {
      _theme = Pallete.darkModeAppTheme;
      await prefs.setBool('isDark', true);
      Pallete.changedTheme = true;
    }
    notifyListeners();
  }
}
