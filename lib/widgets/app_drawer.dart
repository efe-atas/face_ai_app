import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../screens/home_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _currentRoute = '/';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToRoute(BuildContext context, String route) {
    Navigator.pop(context); // Önce drawer'ı kapat

    if (_currentRoute == route) {
      return; // Zaten aynı sayfadaysak bir şey yapma
    }

    if (route == '/') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final currentLanguage = languageProvider.currentLanguage;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-200 * (1 - _animation.value), 0),
          child: Drawer(
            backgroundColor: AppColors.getPrimaryColor(isDarkMode),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // add space
                const SizedBox(height: 100),
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  title: AppStrings.getString('home', currentLanguage),
                  route: '/',
                  isDarkMode: isDarkMode,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.history_outlined,
                  title: AppStrings.getString('history', currentLanguage),
                  route: '/history',
                  isDarkMode: isDarkMode,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.favorite_outline,
                  title: AppStrings.getString('favorites', currentLanguage),
                  route: '/favorites',
                  isDarkMode: isDarkMode,
                ),
                Divider(
                  height: 1,
                  color:
                      AppColors.getTextLightColor(isDarkMode).withOpacity(0.2),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: AppStrings.getString('settings', currentLanguage),
                  route: '/settings',
                  isDarkMode: isDarkMode,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  title: AppStrings.getString('about', currentLanguage),
                  route: '/about',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 16),
                Divider(
                  height: 1,
                  color:
                      AppColors.getTextLightColor(isDarkMode).withOpacity(0.2),
                ),
                const SizedBox(height: 16),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  title: AppStrings.getString('logout', currentLanguage),
                  route: '/login',
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required bool isDarkMode,
  }) {
    final isSelected = _currentRoute == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? AppColors.getAccentColor(isDarkMode)
            : AppColors.getSecondaryColor(isDarkMode),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: isSelected
              ? AppColors.getAccentColor(isDarkMode)
              : AppColors.getTextDarkColor(isDarkMode),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      tileColor: isSelected
          ? AppColors.getAccentColor(isDarkMode).withOpacity(0.1)
          : null,
      onTap: () {
        if (route == '/login') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        } else {
          _navigateToRoute(context, route);
        }
      },
      hoverColor: AppColors.getSecondaryColor(isDarkMode).withOpacity(0.1),
    );
  }
}
