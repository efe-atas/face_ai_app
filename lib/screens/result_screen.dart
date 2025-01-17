// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/theme_provider.dart';

class ResultScreen extends StatelessWidget {
  final String faceShape;

  const ResultScreen({
    super.key,
    required this.faceShape,
  });

  String _getShapeDescription() {
    switch (faceShape.toLowerCase()) {
      case 'heart':
        return 'Kalp şeklinde yüz yapınız var. Alın bölgeniz geniş ve çeneniz sivri.';
      case 'oblong':
        return 'Uzun yüz yapınız var. Yüzünüz uzun ve dar.';
      case 'oval':
        return 'Oval yüz yapınız var. Dengeli ve orantılı hatlar.';
      case 'round':
        return 'Yuvarlak yüz yapınız var. Yumuşak hatlar ve geniş yanaklar.';
      case 'square':
        return 'Kare yüz yapınız var. Güçlü çene hattı ve köşeli hatlar.';
      default:
        return 'Bilinmeyen yüz şekli';
    }
  }

  List<String> _getHairstyleRecommendations() {
    switch (faceShape.toLowerCase()) {
      case 'heart':
        return [
          'Çene Hizasında Bob Kesim',
          'Uzun Katmanlı Saçlar',
          'Yan Perçemli Stiller'
        ];
      case 'oblong':
        return [
          'Hacimli Bob Kesim',
          'Dalgalı Omuz Hizası Saçlar',
          'Yandan Ayrılmış Saçlar'
        ];
      case 'oval':
        return ['Her Türlü Kesim', 'Uzun Düz Saçlar', 'Pixie Kesim'];
      case 'round':
        return [
          'Uzun Katmanlı Kesim',
          'Asimetrik Bob',
          'Yüz Çerçeveleyen Katlar'
        ];
      case 'square':
        return [
          'Yumuşak Dalgalar',
          'Uzun Katmanlı Saçlar',
          'Yan Perçemli Stiller'
        ];
      default:
        return ['Özel saç önerisi bulunmuyor'];
    }
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
                      'Yüz Şekliniz',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.getTextDarkColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      faceShape.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.getAccentColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _getShapeDescription(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.getTextDarkColor(isDarkMode),
                      ),
                    ),
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
              ..._getHairstyleRecommendations()
                  .map((style) => _buildHairstyleCard(
                        style,
                        'Bu stil yüz şeklinize uygun bir seçenek.',
                        Icons.content_cut,
                        isDarkMode,
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHairstyleCard(
      String title, String description, IconData icon, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
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
      ),
    );
  }
}
