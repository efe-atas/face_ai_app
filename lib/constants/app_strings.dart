class AppStrings {
  static const Map<String, Map<String, String>> _strings = {
    'tr': {
      // Ana Sayfa
      'app_title': 'Yüz Şekli Analizi',
      'app_subtitle': 'Size özel saç stilleri',
      'upload_photo': 'Fotoğraf Yükle',
      'text_see_results': 'AI ile sonucu gör',
      'gallery': 'Galeri',

      // Drawer Menü
      'home': 'Ana Sayfa',
      'camera': 'Camera',
      'history': 'Geçmiş Analizler',
      'favorites': 'Favori Stiller',
      'settings': 'Ayarlar',
      'about': 'Hakkında',
      'logout': 'Oturumu Kapat',

      // Ayarlar
      'general_settings': 'Genel Ayarlar',
      'dark_mode': 'Karanlık Mod',
      'dark_mode_desc': 'Uygulama temasını değiştirin',
      'language': 'Dil',
      'language_desc': 'Uygulama dilini değiştirin',
      'notifications': 'Bildirimler',
      'notifications_desc': 'Uygulama bildirimlerini yönetin',
      'turkish': 'Türkçe',
      'english': 'İngilizce',

      // Hakkında
      'version': 'Versiyon 1.0.0',
      'about_app': 'Uygulama Hakkında',
      'about_description':
          'Face Shape AI, yapay zeka teknolojisini kullanarak yüz şeklinizi analiz eder ve size en uygun saç stillerini önerir. Kullanıcı dostu arayüzü ve gelişmiş özellikleriyle, size en iyi saç stilini bulmanızda yardımcı olur.',
      'how_it_works': 'Nasıl Çalışır?',
      'how_it_works_steps':
          '1. Fotoğrafınızı yükleyin\n2. Yapay zeka yüz şeklinizi analiz eder\n3. Size özel saç stilleri önerilir\n4. Beğendiğiniz stili kaydedin',
      'contact': 'İletişim',
      'contact_info':
          'Sorularınız ve önerileriniz için:\nE-posta: info@faceshapeai.com\nTelefon: +90 555 123 4567',
      'copyright': '© 2024 Face Shape AI. Tüm hakları saklıdır.',

      // Geçmiş
      'analysis': 'Analiz',
      'oval': 'Oval',
      'rectangle': 'Dikdörtgen',
      'diamond': 'Elmas',

      // Favoriler
      'hairstyle': 'Saç Stili',
      'trending': 'Trend',
      'added_to_favorites': 'Favorilere eklendi',
      'removed_from_favorites': 'Favorilerden çıkarıldı',
    },
    'en': {
      // Home Page
      'app_title': 'Face Shape Analysis',
      'camera': 'Camera',
      'app_subtitle': 'Personalized hairstyles for you',
      'upload_photo': 'Upload Photo',
      'text_see_results': 'See the results of AI',
      'gallery': 'Gallery',

      // Drawer Menu
      'home': 'Home',
      'history': 'Analysis History',
      'favorites': 'Favorite Styles',
      'settings': 'Settings',
      'about': 'About',
      'logout': 'Logout',

      // Settings
      'general_settings': 'General Settings',
      'dark_mode': 'Dark Mode',
      'dark_mode_desc': 'Change application theme',
      'language': 'Language',
      'language_desc': 'Change application language',
      'notifications': 'Notifications',
      'notifications_desc': 'Manage application notifications',
      'turkish': 'Turkish',
      'english': 'English',

      // About
      'version': 'Version 1.0.0',
      'about_app': 'About App',
      'about_description':
          'Face Shape AI uses artificial intelligence technology to analyze your face shape and recommend the most suitable hairstyles for you. With its user-friendly interface and advanced features, it helps you find the best hairstyle.',
      'how_it_works': 'How It Works?',
      'how_it_works_steps':
          '1. Upload your photo\n2. AI analyzes your face shape\n3. Get personalized hairstyle recommendations\n4. Save your favorite style',
      'contact': 'Contact',
      'contact_info':
          'For questions and suggestions:\nEmail: info@faceshapeai.com\nPhone: +90 555 123 4567',
      'copyright': '© 2024 Face Shape AI. All rights reserved.',

      // History
      'analysis': 'Analysis',
      'oval': 'Oval',
      'rectangle': 'Rectangle',
      'diamond': 'Diamond',

      // Favorites
      'hairstyle': 'Hairstyle',
      'trending': 'Trending',
      'added_to_favorites': 'Added to favorites',
      'removed_from_favorites': 'Removed from favorites',
    },
  };

  static String getString(String key, String languageCode) {
    return _strings[languageCode]?[key] ??
        _strings['tr']![key] ??
        'Key not found';
  }
}
