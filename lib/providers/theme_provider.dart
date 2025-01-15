import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';

  late ThemeMode _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _themeMode = ThemeMode.system;
    _loadThemeFromPrefs();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveThemeToPrefs();
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.system) {
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      _themeMode =
          brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    } else {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }
    _saveThemeToPrefs();
    notifyListeners();
  }

  Future<void> _loadThemeFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themeKey);
      if (savedTheme != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedTheme,
          orElse: () => ThemeMode.system,
        );
        notifyListeners();
      } else {
        // Sistem temasını kullan
        final brightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;
        _themeMode =
            brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Tema yüklenirken hata oluştu: $e');
      _themeMode = ThemeMode.system;
      notifyListeners();
    }
  }

  Future<void> _saveThemeToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, _themeMode.toString());
    } catch (e) {
      debugPrint('Tema kaydedilirken hata oluştu: $e');
    }
  }

  bool isSystemDarkMode() {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }
}
