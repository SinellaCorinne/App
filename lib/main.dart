import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/onboarding/welcome_page.dart';
import 'theme/styles.dart'; 
import 'providers/settings_provider.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

 @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lisez l'état du thème et de la locale depuis les providers
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(appLocaleProvider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noworry App',
      
      // Configuration du Thème
      // ✅ APPEL CORRIGÉ : Sans l'argument context
      theme: appThemeLight(),
      darkTheme: appThemeDark(),
      themeMode: themeMode, 
      
      // Configuration de la Traduction
      locale: locale, 
      supportedLocales: AppLocalizations.supportedLocales, 
      localizationsDelegates: const [
        // Le délégué de localisation de votre application (généré)
        AppLocalizations.delegate, 

        // Les délégués standard de Flutter
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home:
      // const DashboardPage(),
      
       WelcomePage(),
    );
  }
}