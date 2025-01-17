import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/theme_provider.dart';

class AnalysisScreen extends StatelessWidget {
  final String imagePath;
  final Map<String, dynamic> analysisResult;

  const AnalysisScreen({
    super.key,
    required this.imagePath,
    required this.analysisResult,
  });

  Widget _buildAnalysisResult(BuildContext context, bool isDarkMode) {
    final predictions =
        analysisResult['predictions'] as Map<String, dynamic>? ?? {};

    // En yüksek yüzdeye sahip yüz şeklini bul
    String dominantShape = '';
    double maxPercentage = 0;
    predictions.forEach((shape, percentage) {
      if ((percentage as num) > maxPercentage) {
        maxPercentage = percentage.toDouble();
        dominantShape = shape;
      }
    });

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.getSecondaryColor(isDarkMode).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.file(
              File(imagePath),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Yüz Şekliniz',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.getTextDarkColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            dominantShape.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.getAccentColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Yüz Şekli Analizi',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.getTextDarkColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 20),
          ...predictions.entries.map((entry) {
            final percentage = entry.value as num;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.getTextDarkColor(isDarkMode),
                        ),
                      ),
                      Text(
                        '%${percentage.toStringAsFixed(1)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.getAccentColor(isDarkMode),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.getAccentColor(isDarkMode),
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

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
              _buildAnalysisResult(context, isDarkMode),
            ],
          ),
        ),
      ),
    );
  }
}
