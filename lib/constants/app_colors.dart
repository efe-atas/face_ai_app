import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color primaryColorLight = Color(0xFFFFFFFF);
  static const Color secondaryColorLight = Color(0xFFAED9E0);
  static const Color accentColorLight = Color(0xFFF7CED7);
  static const Color textDarkLight = Color(0xFF2D3142);
  static const Color textLightLight = Color(0xFF9C9EB9);
  static const Color backgroundLight = Color(0xFFFAFAFA);

  // Dark Theme Colors
  static const Color primaryColorDark = Color(0xFF1A1A1A);
  static const Color secondaryColorDark = Color(0xFF2C7D8C);
  static const Color accentColorDark = Color(0xFFD88E9D);
  static const Color textDarkDark = Color(0xFFE1E1E1);
  static const Color textLightDark = Color(0xFF9C9EB9);
  static const Color backgroundDark = Color(0xFF121212);

  static Color getPrimaryColor(bool isDarkMode) =>
      isDarkMode ? primaryColorDark : primaryColorLight;
  static Color getSecondaryColor(bool isDarkMode) =>
      isDarkMode ? secondaryColorDark : secondaryColorLight;
  static Color getAccentColor(bool isDarkMode) =>
      isDarkMode ? accentColorDark : accentColorLight;
  static Color getTextDarkColor(bool isDarkMode) =>
      isDarkMode ? textDarkDark : textDarkLight;
  static Color getTextLightColor(bool isDarkMode) =>
      isDarkMode ? textLightDark : textLightLight;
  static Color getBackgroundColor(bool isDarkMode) =>
      isDarkMode ? backgroundDark : backgroundLight;
}
