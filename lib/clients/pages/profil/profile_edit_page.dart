// Fichier : lib/pages/profil/profile_edit_page.dart

import 'package:flutter/material.dart';
import 'package:noworry_app/clients/pages/profil/profile_edit_controller.dart';
import 'package:provider/provider.dart'; // 💡 Import de Provider
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/theme/styles.dart'; 

class PersonalInfoEditPage extends StatelessWidget {
  const PersonalInfoEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Fournit et crée le contrôleur
    return ChangeNotifierProvider<PersonalInfoController>(
      create: (_) => PersonalInfoController(),
      child: const _PersonalInfoEditView(),
    );
  }
}

class _PersonalInfoEditView extends StatelessWidget {
  const _PersonalInfoEditView();

  // Widget réutilisable pour les champs de saisie
  Widget _buildInfoTextField(BuildContext context, String placeholder, TextEditingController controller, {bool isReadOnly = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.grayL, width: 0.5),
      ),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly, // Utilise le paramètre
        decoration: InputDecoration(
          hintText: placeholder,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        style: KTypography.k9(context, color: isReadOnly ? Colors.black54 : AppColors.grayL)?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // 2. Écoute le contrôleur pour l'accès aux données et aux contrôleurs
    final controller = context.watch<PersonalInfoController>();
    
    // Pour les actions (méthodes sans réécouter les changements)
    final readController = context.read<PersonalInfoController>();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,  
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.profileTitle,
          style: KTypography.h4(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold), 
        ),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(width: 60),
            // --- Header (Image, Nom, K-Icon) ---
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage:ExactAssetImage('assets/images/profil.jpg'), 
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 💡 Utilise les données du contrôleur
                    Text(
                      '${controller.currentFirstName} ${controller.currentLastName}',
                      style: KTypography.h5(context)?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.currentPhoneNumber,
                      style: KTypography.h6(context, color: AppColors.grayL),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 30),

            // --- Section 1: Information personnelle ---
            Text(
              l10n.personalInfoTitle,
              style: KTypography.k9(context)?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            
            // 💡 Utilise les contrôleurs fournis par le Controller
            _buildInfoTextField(context, l10n.firstNameLabel, controller.firstNameController),
            _buildInfoTextField(context, l10n.lastNameLabel, controller.lastNameController),
            // Le numéro de téléphone est en lecture seule
            _buildInfoTextField(context, controller.currentPhoneNumber, controller.phoneController, isReadOnly: true),

            const SizedBox(height: 24),

            // --- Section 2: Adresse ---
            Text(
              l10n.addressLabel,
              style: KTypography.k9(context)?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            
            // Champ de texte multiligne pour l'adresse
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color:AppColors.grayL, width: 0.5),
              ),
              child: TextField(
                // 💡 Utilise le contrôleur d'adresse
                controller: controller.addressController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: KTypography.k9(context, color: AppColors.grayL)?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            
            const SizedBox(height: 60),

            // --- Bouton Sauvegarder ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // 💡 Appelle la méthode de sauvegarde du contrôleur
                onPressed: () => readController.handleSave(context, l10n),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Text(
                  l10n.saveButton,
                  style: KTypography.k9(context, color: Colors.white)?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}