import 'package:pomothing/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  ThemeData get themeData {
    if (isDarkMode) {
      return darkMode;
    } else {
      return lightMode;
    }
  }

  Future<void> toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', themeMode.toString());
    notifyListeners();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeString = prefs.getString('themeMode');

    if (themeString == 'ThemeMode.dark') {
      themeMode = ThemeMode.dark;
    } else if (themeString == 'ThemeMode.light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }

    notifyListeners();
  }
}
