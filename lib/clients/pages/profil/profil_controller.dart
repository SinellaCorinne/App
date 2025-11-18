// Fichier : lib/pages/profil/profile_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/clients/pages/profil/profile_edit_page.dart';
import 'package:noworry_app/clients/pages/setting/settings.dart';

class ProfileController extends ChangeNotifier {
  // --- État Local (Code Promo) ---
  String _promoCode = '';
  String get promoCode => _promoCode;

  void updatePromoCode(String code) {
    _promoCode = code;
    // Pas besoin de notifier les auditeurs ici, car seul le bouton "Appliquer" 
    // a besoin de connaître la valeur, et il le fera via le getter.
    // Cependant, si d'autres parties de l'UI devaient réagir à la saisie, notifyListeners() serait nécessaire.
  }

  // --- Logique de Navigation ---

  void handleNavigation(BuildContext context, String actionKey, AppLocalizations l10n) {
     // Utiliser la clé de traduction pour une vérification robuste
     if (actionKey == l10n.myInfoLabel) {
        // Navigation vers la page d'édition des informations personnelles
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PersonalInfoEditPage(),
            ),
        );
     } else {
       // Logique pour d'autres options (Assistance, etc.)
       debugPrint('Action du profil: $actionKey');
       // Ajoutez ici la logique réelle pour WhatsApp, etc.
     }
  }

  void handleSettingsNavigation(BuildContext context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
  }

  // --- Logique d'Action ---

  void handleApplyPromo(BuildContext context, AppLocalizations l10n) {
     final code = _promoCode.trim();
     if (code.isNotEmpty) {
       debugPrint('Application du code promo: $code');
       
       

       
     }
  }
}