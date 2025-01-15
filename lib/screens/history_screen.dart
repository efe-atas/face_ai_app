import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
          AppStrings.getString('history', currentLanguage),
          style: GoogleFonts.poppins(
            color: AppColors.getTextDarkColor(isDarkMode),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: AppColors.getPrimaryColor(isDarkMode),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.getAccentColor(isDarkMode)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.face,
                          color: AppColors.getAccentColor(isDarkMode),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppStrings.getString('analysis', currentLanguage)} #${index + 1}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.getTextDarkColor(isDarkMode),
                              ),
                            ),
                            Text(
                              '${DateTime.now().subtract(Duration(days: index)).day}/${DateTime.now().subtract(Duration(days: index)).month}/${DateTime.now().subtract(Duration(days: index)).year}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.getTextLightColor(isDarkMode),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.getTextDarkColor(isDarkMode),
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/result');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.getSecondaryColor(isDarkMode)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildShapePercentage(
                          AppStrings.getString('oval', currentLanguage),
                          '75%',
                          isDarkMode,
                        ),
                        _buildShapePercentage(
                          AppStrings.getString('rectangle', currentLanguage),
                          '15%',
                          isDarkMode,
                        ),
                        _buildShapePercentage(
                          AppStrings.getString('diamond', currentLanguage),
                          '10%',
                          isDarkMode,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShapePercentage(
      String shape, String percentage, bool isDarkMode) {
    return Column(
      children: [
        Text(
          percentage,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.getTextDarkColor(isDarkMode),
          ),
        ),
        Text(
          shape,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.getTextLightColor(isDarkMode),
          ),
        ),
      ],
    );
  }
}
