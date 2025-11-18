import 'package:flutter/material.dart';

// --- Définition des couleurs ---
class AppColors {
  // Couleurs principales
  static const Color primary = Color(0xFF006400); // Vert foncé
  static const Color secondary = Color(0xFFE6F4EA); // Vert très pâle (clair)
  static const Color tertiary = Color(0xFFFFD700); // Jaune doré

  // Couleurs neutres
  static const Color grayD = Color(0xFF333333); // Gris foncé
  static const Color grayL = Color(0xFFD3D3D3); // Gris clair
  static const Color orange = Color(0xFFEB8E00); // Orange (utilisé pour les barres ou accents)
  static const Color orangeP =Color(0xFFFF9F0D);
  static const Color indigo =Color(0xFF427985);
  static const Color blue= Color(0xFF2457C5);
  // Couleurs spécifiques au texte/fond (Dark Mode)
  static const Color darkBackground = Color(0xFF333333); // Fond très sombre pour le mode nuit
  static const Color darkSurface = Color(0xFF1E1E1E); // Surfaces plus claires pour les cartes
  static const Color darkTextPrimary = Colors.white; // Texte clair
  static const Color darkTextSecondary =Colors.white; // Texte secondaire
}

// ===========================================
// 1. Thème Clair (Light Theme)
// ===========================================
// ✅ Retiré BuildContext context
ThemeData appThemeLight() {
  return  ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    
    // Paramètres principaux de l'apparence
    scaffoldBackgroundColor: Color(0xFFFCFFFD),
    cardColor: Colors.white,
    dividerColor: AppColors.grayL,
    useMaterial3: true, // Recommandé

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: Colors.white,
      onSurface: Colors.black, // Texte sur les surfaces
      // Texte sur le fond
      error: Colors.red,
    ),

    // Configuration de la typographie pour le mode clair
    textTheme: const TextTheme(
       headlineLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.primary, // H1 en jaune
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color:Colors.black,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.orange,
      ),
      labelLarge: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),

      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      
       titleMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.black, // Texte par défaut en gris clair
      ),
      bodySmall: TextStyle(
       fontFamily: 'Montserrat',
       fontSize: 13,
       fontWeight: FontWeight.normal,
       color: Colors.black, 
      ),
       labelSmall: TextStyle(
       fontFamily: 'Montserrat',
       fontSize: 12,
       fontWeight: FontWeight.normal,
       color: Colors.black, 
      ) ,
      labelMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 11,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 8,
        fontWeight: FontWeight.normal,
        color: Colors.black, // Texte par défaut en gris clair
      ),
    ),
  );
}

// ===========================================
// 2. Thème Sombre (Dark Theme)
// ===========================================
ThemeData appThemeDark() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.tertiary, // Utiliser le jaune comme couleur primaire dans le thème sombre
    useMaterial3: true, // Recommandé

    // Paramètres principaux de l'apparence
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkSurface, // Cartes légèrement plus claires
    dividerColor: AppColors.grayD,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.tertiary, // Le jaune doré se voit bien sur le noir
      secondary: AppColors.primary, // Le vert foncé peut servir de couleur secondaire
      tertiary: AppColors.orange,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary, 
      error: Colors.redAccent,
    ),

    // Configuration de la typographie pour le mode sombre
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.tertiary, // H1 en jaune
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color:Colors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.orange,
      ),
      labelLarge: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),

      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      
       titleMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.white, // Texte par défaut en gris clair
      ),
      bodySmall: TextStyle(
       fontFamily: 'Montserrat',
       fontSize: 13,
       fontWeight: FontWeight.normal,
       color: Colors.white, 
      ),
       labelSmall: TextStyle(
       fontFamily: 'Montserrat',
       fontSize: 12,
       fontWeight: FontWeight.normal,
       color: Colors.white, 
      ) ,
      labelMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 11,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 8,
        fontWeight: FontWeight.normal,
        color: Colors.white, // Texte par défaut en gris clair
      ),
    ),
  );
}

// ===========================================
// KTypography (Gère la lecture du thème)
// ===========================================
class KTypography {
  static TextStyle? h1(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.headlineLarge?.copyWith(color: color);
  }

  static TextStyle? h2(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.headlineMedium?.copyWith(color: color);
  }

  static TextStyle? h3(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.headlineSmall?.copyWith(color: color);
  }

  static TextStyle? h4(BuildContext context, {Color? color}) {
  
    return Theme.of(context).textTheme.bodyLarge?.copyWith(color: color);
  }

  static TextStyle? h5(BuildContext context, {Color? color}) {
  
    return Theme.of(context).textTheme.titleMedium?.copyWith(color: color);
  }

  static TextStyle? h6(BuildContext context, {Color? color}) {
   
    return Theme.of(context).textTheme.bodySmall?.copyWith(color: color);
  }
  
  static TextStyle? h7(BuildContext context, {Color? color}){
    return Theme.of(context).textTheme.labelMedium?.copyWith(color:color);
  }

   static TextStyle? h8(BuildContext context, {Color? color}) {
   
    return Theme.of(context).textTheme.bodyMedium?.copyWith(color: color);
  }
  static TextStyle? k8(BuildContext context, {Color? color}) {
   
    return Theme.of(context).textTheme.labelLarge?.copyWith(color: color);
  }
   static TextStyle? k9(BuildContext context, {Color? color}){
   
   return Theme.of(context).textTheme.labelSmall?.copyWith(color:color);
   }
}