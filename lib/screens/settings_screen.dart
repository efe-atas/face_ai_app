import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final currentLanguage = languageProvider.currentLanguage;

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(isDarkMode),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: AppColors.getTextDarkColor(isDarkMode)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.getString('settings', currentLanguage),
          style: GoogleFonts.poppins(
            color: AppColors.getTextDarkColor(isDarkMode),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                AppStrings.getString('general_settings', currentLanguage),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextDarkColor(isDarkMode),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.getPrimaryColor(isDarkMode),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSettingsTile(
                    AppStrings.getString('notifications', currentLanguage),
                    AppStrings.getString('notifications_desc', currentLanguage),
                    Icons.notifications_outlined,
                    trailing: Switch(
                      value: notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          notificationsEnabled = value;
                        });
                      },
                      activeColor: AppColors.getSecondaryColor(isDarkMode),
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingsTile(
                    AppStrings.getString('dark_mode', currentLanguage),
                    AppStrings.getString('dark_mode_desc', currentLanguage),
                    Icons.dark_mode_outlined,
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      activeColor: AppColors.getSecondaryColor(isDarkMode),
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingsTile(
                    AppStrings.getString('language', currentLanguage),
                    AppStrings.getString('language_desc', currentLanguage),
                    Icons.language_outlined,
                    trailing: DropdownButton<String>(
                      value: currentLanguage,
                      underline: const SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: 'tr',
                          child: Text(
                            AppStrings.getString('turkish', currentLanguage),
                            style: GoogleFonts.poppins(
                              color: AppColors.getTextDarkColor(isDarkMode),
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(
                            AppStrings.getString('english', currentLanguage),
                            style: GoogleFonts.poppins(
                              color: AppColors.getTextDarkColor(isDarkMode),
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          languageProvider.setLanguage(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon, {
    Widget? trailing,
    bool showArrow = false,
  }) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.getSecondaryColor(isDarkMode),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.getTextDarkColor(isDarkMode),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.getTextLightColor(isDarkMode),
        ),
      ),
      trailing: trailing ??
          (showArrow
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColors.getTextLightColor(isDarkMode),
                )
              : null),
    );
  }
}
