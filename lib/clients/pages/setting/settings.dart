

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noworry_app/providers/settings_provider.dart';
import 'package:noworry_app/theme/styles.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupérer l'instance de localisation
    final l = AppLocalizations.of(context)!;
    
    // Lire l'état actuel des providers
    final themeMode = ref.watch(themeModeProvider);
    final currentLocale = ref.watch(appLocaleProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l.settingsTitle), // 👈 Vous devrez ajouter 'settingsTitle' à vos fichiers .arb
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          
          // --- A. Sélecteur de Thème (Mode Clair / Sombre) ---
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      l.themeSettings, // 👈 'themeSettings'
                      style: KTypography.h4(context, color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  
                  // Option 1: Thème du Système
                  RadioListTile<ThemeMode>(
                    title: Text(l.themeSystem), // 👈 'themeSystem'
                    value: ThemeMode.system,
                    groupValue: themeMode,
                    onChanged: (mode) {
                      if (mode != null) {
                        ref.read(themeModeProvider.notifier).setThemeMode(mode);
                      }
                    },
                  ),
                  
                  // Option 2: Thème Clair
                  RadioListTile<ThemeMode>(
                    title: Text(l.themeLight), // 👈 'themeLight'
                    value: ThemeMode.light,
                    groupValue: themeMode,
                    onChanged: (mode) {
                      if (mode != null) {
                        ref.read(themeModeProvider.notifier).setThemeMode(mode);
                      }
                    },
                  ),

                  // Option 3: Thème Sombre
                  RadioListTile<ThemeMode>(
                    title: Text(l.themeDark), // 👈 'themeDark'
                    value: ThemeMode.dark,
                    groupValue: themeMode,
                    onChanged: (mode) {
                      if (mode != null) {
                        ref.read(themeModeProvider.notifier).setThemeMode(mode);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- B. Sélecteur de Langue ---
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.languageSettings, // 👈 'languageSettings'
                    style: KTypography.h4(context, color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 10),
                  
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                       labelText: l.selectLanguage, // 👈 'selectLanguage'
                       border: const OutlineInputBorder(),
                    ),
                    value: currentLocale.languageCode,
                    items: AppLocalizations.supportedLocales.map((Locale locale) {
                      return DropdownMenuItem<String>(
                        value: locale.languageCode,
                        // Afficher le nom complet de la langue
                        child: Text(
                          locale.languageCode == 'fr' ? "Français" : "English",
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        final newLocale = Locale(newValue, newValue.toUpperCase());
                        // Accès au Notifier pour changer la Locale
                        ref.read(appLocaleProvider.notifier).setLocale(newLocale);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}