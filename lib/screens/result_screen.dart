// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/theme_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  List<Map<String, dynamic>> _getSortedPercentages() {
    final percentages = [
      {'shape': 'Elmas', 'percentage': 0.11},
      {'shape': 'Dikdörtgen', 'percentage': 0.29},
      {'shape': 'Oval', 'percentage': 0.05},
    ];

    // Yüzdelere göre büyükten küçüğe sırala
    percentages.sort((a, b) =>
        (b['percentage'] as double).compareTo(a['percentage'] as double));
    return percentages;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    // Sıralanmış yüzdeleri al
    final sortedPercentages = _getSortedPercentages();

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
          'Analiz Sonucu',
          style: GoogleFonts.poppins(
            color: AppColors.getTextDarkColor(isDarkMode),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:
                      AppColors.getSecondaryColor(isDarkMode).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.getAccentColor(isDarkMode),
                      child: Icon(
                        Icons.face,
                        size: 60,
                        color: AppColors.getPrimaryColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Yüz Şekli Analizi',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.getTextDarkColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...sortedPercentages
                        .map((item) => _buildPercentageIndicator(
                              item['shape'],
                              item['percentage'],
                              isDarkMode,
                            )),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Önerilen Saç Stilleri',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextDarkColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 20),
              _buildHairstyleCard(
                'Katmanlı Kesim',
                'Yüz hatlarınızı yumuşatacak ve oval şeklinizi vurgulayacak bir stil.',
                Icons.content_cut,
                isDarkMode,
              ),
              const SizedBox(height: 15),
              _buildHairstyleCard(
                'Dalgalı Bob Kesim',
                'Yüz şeklinize hacim katacak modern bir seçenek.',
                Icons.waves,
                isDarkMode,
              ),
              const SizedBox(height: 15),
              _buildHairstyleCard(
                'Uzun Düz Kesim',
                'Yüz hatlarınızı dengeli gösterecek klasik bir tercih.',
                Icons.straighten,
                isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPercentageIndicator(
      String label, double percentage, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.getTextDarkColor(isDarkMode),
                ),
              ),
              Text(
                '${(percentage * 100).toInt()}%',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextDarkColor(isDarkMode),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: AppColors.getPrimaryColor(isDarkMode),
            valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.getAccentColor(isDarkMode)),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildHairstyleCard(
      String title, String description, IconData icon, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColor(isDarkMode),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.getAccentColor(isDarkMode).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.getAccentColor(isDarkMode),
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.getTextDarkColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.getTextLightColor(isDarkMode),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
