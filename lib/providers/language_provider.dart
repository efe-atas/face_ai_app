import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'language_code';
  String _currentLanguage = 'tr';

  String get currentLanguage => _currentLanguage;

  LanguageProvider() {
    _loadLanguage();
  }

  void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
    _saveLanguage();
    notifyListeners();
  }

  void toggleLanguage() {
    _currentLanguage = _currentLanguage == 'tr' ? 'en' : 'tr';
    _saveLanguage();
    notifyListeners();
  }

  Future<void> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _currentLanguage = prefs.getString(_languageKey) ?? 'tr';
      notifyListeners();
    } catch (e) {
      debugPrint('Dil yüklenirken hata oluştu: $e');
    }
  }

  Future<void> _saveLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, _currentLanguage);
    } catch (e) {
      debugPrint('Dil kaydedilirken hata oluştu: $e');
    }
  }
}
