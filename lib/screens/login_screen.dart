import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Dummy login logic
    if (_emailController.text == 'test@test.com' &&
        _passwordController.text == '123456') {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Geçersiz e-posta veya şifre!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(isDarkMode),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.getSecondaryColor(isDarkMode)
                          // ignore: deprecated_member_use
                          .withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.face,
                      size: 60,
                      color: AppColors.getSecondaryColor(isDarkMode),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Hoş Geldiniz',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextDarkColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Devam etmek için giriş yapın',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.getTextLightColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  style: GoogleFonts.poppins(
                    color: AppColors.getTextDarkColor(isDarkMode),
                  ),
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                    labelStyle: GoogleFonts.poppins(
                      color: AppColors.getTextLightColor(isDarkMode),
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.getSecondaryColor(isDarkMode),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.getSecondaryColor(isDarkMode)
                            .withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.getAccentColor(isDarkMode),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: GoogleFonts.poppins(
                    color: AppColors.getTextDarkColor(isDarkMode),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    labelStyle: GoogleFonts.poppins(
                      color: AppColors.getTextLightColor(isDarkMode),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppColors.getSecondaryColor(isDarkMode),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.getSecondaryColor(isDarkMode),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.getSecondaryColor(isDarkMode)
                            .withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.getAccentColor(isDarkMode),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Şifremi unuttum işlemi
                    },
                    child: Text(
                      'Şifremi Unuttum',
                      style: GoogleFonts.poppins(
                        color: AppColors.getAccentColor(isDarkMode),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.getAccentColor(isDarkMode),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Giriş Yap',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hesabınız yok mu?',
                      style: GoogleFonts.poppins(
                        color: AppColors.getTextLightColor(isDarkMode),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Kayıt ol sayfasına yönlendirme
                      },
                      child: Text(
                        'Kayıt Ol',
                        style: GoogleFonts.poppins(
                          color: AppColors.getAccentColor(isDarkMode),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
