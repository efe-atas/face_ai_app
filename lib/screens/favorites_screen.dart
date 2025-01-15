// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? _hoveredIndex;
  final List<bool> _favorites = List.generate(6, (index) => true);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite(int index) {
    setState(() {
      _favorites[index] = !_favorites[index];
    });
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final currentLanguage = languageProvider.currentLanguage;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _favorites[index]
              ? AppStrings.getString('added_to_favorites', currentLanguage)
              : AppStrings.getString('removed_from_favorites', currentLanguage),
          style: GoogleFonts.poppins(),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.getTextDarkColor(isDarkMode),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.getString('favorites', currentLanguage),
          style: GoogleFonts.poppins(
            color: AppColors.getTextDarkColor(isDarkMode),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return MouseRegion(
              onEnter: (_) => setState(() => _hoveredIndex = index),
              onExit: (_) => setState(() => _hoveredIndex = null),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.identity()
                  ..scale(_hoveredIndex == index ? 1.02 : 1.0),
                child: Card(
                  elevation: _hoveredIndex == index ? 4 : 2,
                  color: AppColors.getPrimaryColor(isDarkMode),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.getSecondaryColor(isDarkMode)
                                .withOpacity(0.2),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: AnimatedScale(
                              scale: _hoveredIndex == index ? 1.1 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.face,
                                size: 40,
                                color: AppColors.getSecondaryColor(isDarkMode)
                                    .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${AppStrings.getString('hairstyle', currentLanguage)} ${index + 1}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.getTextDarkColor(isDarkMode),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.getAccentColor(isDarkMode)
                                              .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      AppStrings.getString(
                                          'trending', currentLanguage),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: AppColors.getAccentColor(
                                            isDarkMode),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => _toggleFavorite(index),
                                    child: AnimatedScale(
                                      scale: _hoveredIndex == index ? 1.2 : 1.0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: Icon(
                                        _favorites[index]
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.getAccentColor(
                                            isDarkMode),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
