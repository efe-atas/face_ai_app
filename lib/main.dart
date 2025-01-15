import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/history_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'screens/login_screen.dart';
import 'constants/app_colors.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Face Shape AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.getSecondaryColor(false),
          primary: AppColors.getSecondaryColor(false),
          secondary: AppColors.getAccentColor(false),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: AppColors.getBackgroundColor(false),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.getSecondaryColor(true),
          primary: AppColors.getSecondaryColor(true),
          secondary: AppColors.getAccentColor(true),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: AppColors.getBackgroundColor(true),
        useMaterial3: true,
      ),
      themeMode: themeProvider.themeMode,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
