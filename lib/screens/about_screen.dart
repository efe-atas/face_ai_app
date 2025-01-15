// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.getTextDarkColor(isDarkMode),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.getString('about', currentLanguage),
          style: GoogleFonts.poppins(
            color: AppColors.getTextDarkColor(isDarkMode),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color:
                      AppColors.getSecondaryColor(isDarkMode).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.face,
                  size: 60,
                  color: AppColors.getSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Face Shape AI',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextDarkColor(isDarkMode),
                ),
              ),
              Text(
                AppStrings.getString('version', currentLanguage),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.getTextLightColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 40),
              _buildInfoSection(
                AppStrings.getString('about_app', currentLanguage),
                AppStrings.getString('about_description', currentLanguage),
                isDarkMode,
              ),
              const SizedBox(height: 24),
              _buildInfoSection(
                AppStrings.getString('how_it_works', currentLanguage),
                AppStrings.getString('how_it_works_steps', currentLanguage),
                isDarkMode,
              ),
              const SizedBox(height: 24),
              _buildInfoSection(
                AppStrings.getString('contact', currentLanguage),
                AppStrings.getString('contact_info', currentLanguage),
                isDarkMode,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(Icons.facebook, () {}, isDarkMode),
                  const SizedBox(width: 20),
                  _buildSocialButton(Icons.photo_camera, () {}, isDarkMode),
                  const SizedBox(width: 20),
                  _buildSocialButton(Icons.alternate_email, () {}, isDarkMode),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                AppStrings.getString('copyright', currentLanguage),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.getTextLightColor(isDarkMode),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.getTextDarkColor(isDarkMode),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.getTextLightColor(isDarkMode),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      IconData icon, VoidCallback onTap, bool isDarkMode) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.getSecondaryColor(isDarkMode).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColors.getSecondaryColor(isDarkMode),
          size: 24,
        ),
      ),
    );
  }
}
