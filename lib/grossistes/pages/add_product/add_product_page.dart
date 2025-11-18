// Fichier : lib/pages/product/add_product_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noworry_app/components/ui/label_qte.dart';
import 'package:noworry_app/components/forms/photo_picker.dart';
import 'package:noworry_app/components/ui/text_label.dart';
import 'package:noworry_app/theme/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'add_product_controller.dart'; // 💡 Import du contrôleur


class AddProductPage extends StatelessWidget {
AddProductPage({super.key});
  
  // Clé du formulaire pour la validation
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // 1. Fournit le contrôleur à la page
    return ChangeNotifierProvider<AddProductController>(
      create: (_) => AddProductController(),
      child: _AddProductView(formKey: _formKey),
    );
  }
}

class _AddProductView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _AddProductView({required this.formKey});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    // 2. Écoute le contrôleur (pour les mises à jour comme l'unité)
    final controller = context.watch<AddProductController>();
    
    // 3. Obtient l'instance pour les appels d'action
    final readController = context.read<AddProductController>();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),

        title: Text(
          l.addProductTitle,
          style: KTypography.h1(context)?.copyWith(fontSize: 16.0),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔑 Titre produit
                TextLabel(text: l.titleProduct),
                TextFieldCompose(
                  hint: l.enterTitle,
                  requiredError: l.fieldRequiredError,
                 // 💡 Liaison du contrôleur
                ),

                const SizedBox(height: 15),

                // 🔑 Détails produit
                TextLabel(text: l.detailProduct),
                TextFieldCompose(
                  hint: l.enterDetail,
                  requiredError: l.fieldRequiredError,
                  // 💡 Liaison du contrôleur
                ),

                const SizedBox(height: 15),

                // 🔑 Catégorie
                TextLabel(text: l.categoryProduct),
                TextFieldCompose(
                  hint: l.enterCategory,
                  requiredError: l.fieldRequiredError,
                 // 💡 Liaison du contrôleur
                ),

                const SizedBox(height: 15),

                // 🔑 Quantité
                TextLabel(text: l.qteProduct),
                InputWithUnitSuffix(
                  // 💡 Liaison de la méthode du contrôleur
                  onUnitChanged: (value) => readController.updateUnit("KG"), 
                  hintText: l.enterQte,
                  // 💡 Liaison du contrôleur
                  controller: controller.qteController, 
                ),

                const SizedBox(height: 15),

                // 🔑 Prix
                TextLabel(text: l.priceProduct),
                TextFieldCompose(
                  hint: l.enterPrice,
                  requiredError: l.fieldRequiredError,
                  // 💡 Liaison du contrôleur
                ),

                const SizedBox(height: 15),

                // 🔑 Image
                TextLabel(text: l.imageProduct),
                const PhotoPickerComponent(
                  // 💡 Vous pouvez lier l'état de l'image ici si PhotoPickerComponent est modifié pour accepter un callback.
                  // onImageSelected: readController.updateImage,
                ),

                const SizedBox(height: 15),

                // 🔑 Bouton soumis
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // 💡 Appelle la méthode de soumission du contrôleur
                    onPressed: () => readController.submitForm(context, formKey, l),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      l.saveProduct, 
                      style: KTypography.k9(
                        context,
                        color: Colors.white,
                      )?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}