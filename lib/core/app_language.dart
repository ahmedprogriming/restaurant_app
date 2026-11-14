import 'package:flutter/material.dart';

/// Centralized Application Language Manager.
///
/// Uses [ValueNotifier<Locale>] to manage the application locale globally.
/// When [toggleLanguage] or [setLocale] is called, [RestaurantApp] rebuilds
/// immediately, updating the locale and directionality (LTR/RTL) across all screens.
class AppLanguage {
  // Default to English ('en') to match the reference design mockup.
  static final ValueNotifier<Locale> currentLocale =
      ValueNotifier<Locale>(const Locale('en'));

  /// Helper getter to check if the current active language is Arabic.
  static bool get isArabic => currentLocale.value.languageCode == 'ar';

  /// Toggles between English ('en') and Arabic ('ar').
  static void toggleLanguage() {
    if (isArabic) {
      currentLocale.value = const Locale('en');
    } else {
      currentLocale.value = const Locale('ar');
    }
  }

  /// Sets the application locale directly.
  static void setLocale(Locale locale) {
    currentLocale.value = locale;
  }
}
