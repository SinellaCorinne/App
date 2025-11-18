import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ------------------------------------------------------------------
// A. Provider pour le Thème (ThemeMode)
// ------------------------------------------------------------------

/// 1. Définition du Notifier (pour modifier l'état)
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  // Thème par défaut : celui du système
  ThemeModeNotifier() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      // Si on est en mode système, on bascule vers le mode opposé du système
      // (la logique d'interface utilisateur déterminera le mode actuel)
      // Pour simplifier, nous basculons entre light et dark
      state = ThemeMode.dark;
    }
  }
}

/// 2. Définition du Provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});


// ------------------------------------------------------------------
// B. Provider pour la Langue (Locale)
// ------------------------------------------------------------------

/// 1. Définition du Notifier (pour modifier l'état)
class AppLocaleNotifier extends StateNotifier<Locale> {
  // Locale par défaut (ex: français)
  AppLocaleNotifier() : super(const Locale('fr', 'FR'));

  void setLocale(Locale newLocale) {
    state = newLocale;
  }
}

/// 2. Définition du Provider
final appLocaleProvider = StateNotifierProvider<AppLocaleNotifier, Locale>((ref) {
  return AppLocaleNotifier();
});