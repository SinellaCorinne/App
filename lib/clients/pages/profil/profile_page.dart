// Fichier : lib/pages/profil/profile_page.dart

import 'package:flutter/material.dart';
import 'package:noworry_app/clients/pages/profil/profil_controller.dart';
import 'package:provider/provider.dart'; 
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 
import 'package:iconsax/iconsax.dart' show Iconsax;
import 'package:noworry_app/components/cards/profile_option_tile.dart';
import 'package:noworry_app/theme/styles.dart'; 
import'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Fournit et crée le contrôleur
    return ChangeNotifierProvider<ProfileController>(
      create: (_) => ProfileController(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  static const Color primaryOrange = AppColors.tertiary; 
  static const Color primaryGreen = AppColors.primary;
  
  // Clé pour réinitialiser le champ de texte si le code est appliqué
  final _promoCodeKey = const ValueKey('promoCodeTextField');


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // 2. Écoute le contrôleur pour les changements (comme la réinitialisation du code promo)
    final controller = context.watch<ProfileController>();
    
    // Pour les actions (méthodes sans réécouter les changements)
    final readController = context.read<ProfileController>(); 

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent, 
        elevation: 0,  
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.profileTitle,
          style: KTypography.h4(context, color: primaryGreen)?.copyWith(fontWeight: FontWeight.bold), 
        ),
        centerTitle: true,
        actions: [
           IconButton( 
            icon: const Icon(Icons.settings),
            // 💡 Appelle la méthode du contrôleur pour la navigation
            onPressed: () => readController.handleSettingsNavigation(context),
           ),
        ],
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Mes informations ---
            ProfileOptionTile(
              label: l10n.myInfoLabel,
              suffixIcon: Iconsax.arrow_right_1, 
              // 💡 Appelle le contrôleur avec la clé de traduction
              onTap: () => readController.handleNavigation(context, l10n.myInfoLabel, l10n), 
            ),
            
            const SizedBox(height: 6),
            // --- 2. Demander assistance ---
            ProfileOptionTile(
              label: l10n.requestAssistanceLabel,
              suffixIcon: FontAwesomeIcons.whatsapp, 
              // 💡 Appelle le contrôleur avec la clé de traduction
              onTap: () => readController.handleNavigation(context, l10n.requestAssistanceLabel, l10n),
            ),

            const SizedBox(height: 6),
            
            // --- 3. Code Promo ---
            Row(
              children: [
                // Champ "Code Promo" (Conteneur statique)
                Container(
                  width: 100, 
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: AppColors.grayL, width: 1),
                  ),
                  child: Text(
                    l10n.promoCodeLabel,
                    style: KTypography.k9(context)?.copyWith(fontWeight: FontWeight.w500), 
                  ),
                ),
                
                const SizedBox(width: 4),
                
                // Champ de saisie du code et bouton Appliquer
                Container(
                  width: 223,
                  height: 36,
                   decoration: BoxDecoration(
                    color:Colors.transparent,
                    border: Border.all(color:AppColors.grayL, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        
                          child: TextField(
                            key: _promoCodeKey, // Clé pour forcer la reconstruction si le code est effacé
                            controller: TextEditingController(text: controller.promoCode), // 💡 Utilise l'état du contrôleur
                            decoration: InputDecoration(
                              labelStyle: KTypography.k9(context)?.copyWith(fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            // 💡 Met à jour l'état du contrôleur à chaque saisie
                            onChanged: readController.updatePromoCode,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35, 
                        child: ElevatedButton(
                          // 💡 Appelle la méthode d'action du contrôleur
                          onPressed: () => readController.handleApplyPromo(context, l10n),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: Text(
                            l10n.applyButton,
                            style: KTypography.k9(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 300), 
            
            // --- Icônes 'K' simulées ---
            
           
          ],
        ),
      ),
    );
  }
}