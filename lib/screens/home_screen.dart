// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../widgets/app_drawer.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _processImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultScreen(),
        ),
      );
    }
  }

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
        iconTheme: IconThemeData(color: AppColors.getTextDarkColor(isDarkMode)),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.getString('app_title', currentLanguage),
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextDarkColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppStrings.getString('app_subtitle', currentLanguage),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.getTextLightColor(isDarkMode),
                    letterSpacing: 0.3,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),
                MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.identity()
                      ..scale(_isHovered ? 1.02 : 1.0),
                    child: GestureDetector(
                      onTap: () => _processImage(ImageSource.gallery),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.getSecondaryColor(isDarkMode)
                                  .withOpacity(0.2),
                              AppColors.getAccentColor(isDarkMode)
                                  .withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.getSecondaryColor(isDarkMode),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: 1.0 + (_controller.value * 0.1),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: AppColors.getSecondaryColor(
                                              isDarkMode)
                                          .withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 40,
                                      color: AppColors.getSecondaryColor(
                                          isDarkMode),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppStrings.getString(
                                  'upload_photo', currentLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: AppColors.getTextDarkColor(isDarkMode),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppStrings.getString(
                                  'text_see_results', currentLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.getTextLightColor(isDarkMode),
                                letterSpacing: 0.3,
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildOptionButton(
                        icon: Icons.camera_alt_outlined,
                        text: AppStrings.getString('camera', currentLanguage),
                        onTap: () => _processImage(ImageSource.camera),
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildOptionButton(
                        icon: Icons.photo_library_outlined,
                        text: AppStrings.getString('gallery', currentLanguage),
                        onTap: () => _processImage(ImageSource.gallery),
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.getPrimaryColor(isDarkMode),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(isDarkMode ? 0.05 : 0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.getString('how_it_works', currentLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.getTextDarkColor(isDarkMode),
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildStepItem(
                        icon: Icons.face_outlined,
                        title: 'Yüz Analizi',
                        description: 'Yapay zeka yüz şeklinizi analiz eder',
                        isDarkMode: isDarkMode,
                      ),
                      _buildStepItem(
                        icon: Icons.auto_awesome_outlined,
                        title: 'Stil Önerisi',
                        description: 'Size en uygun saç stilleri önerilir',
                        isDarkMode: isDarkMode,
                      ),
                      _buildStepItem(
                        icon: Icons.calendar_today_outlined,
                        title: 'Randevu',
                        description: 'Seçtiğiniz stil için randevu alın',
                        showDivider: false,
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.getAccentColor(isDarkMode).withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.getAccentColor(isDarkMode),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.getTextDarkColor(isDarkMode),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.getTextDarkColor(isDarkMode),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required IconData icon,
    required String title,
    required String description,
    bool showDivider = true,
    required bool isDarkMode,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.getSecondaryColor(isDarkMode).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColors.getSecondaryColor(isDarkMode),
                size: 20,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.getTextDarkColor(isDarkMode),
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.getTextLightColor(isDarkMode),
                      letterSpacing: 0.3,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              color: AppColors.getTextLightColor(isDarkMode).withOpacity(0.2),
            ),
          ),
      ],
    );
  }
}
