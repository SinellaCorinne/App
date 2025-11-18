// Fichier : lib/pages/product/add_product_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// Note: Simule l'importation de Dart:io pour le type File
// Si vous utilisez ImagePicker, le type pourrait être XFile ou File.
// Pour l'exemple, nous utilisons String pour simuler le chemin d'accès.
// import 'dart:io';

class AddProductController extends ChangeNotifier {
  // --- Contrôleurs de Texte ---
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController qteController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // --- État Additionnel ---
  String _selectedUnit = "KG"; // Unité par défaut
  String get selectedUnit => _selectedUnit;

  // String? _selectedImagePath; // Le chemin vers l'image sélectionnée
  // String? get selectedImagePath => _selectedImagePath;

  // --- Logique d'Action ---

  void updateUnit(String newUnit) {
    _selectedUnit = newUnit;
    notifyListeners();
  }
  
  // void updateImage(String? path) {
  //   _selectedImagePath = path;
  //   notifyListeners();
  // }

  void submitForm(BuildContext context, GlobalKey<FormState> formKey, AppLocalizations l10n) {
    if (formKey.currentState?.validate() ?? false) {
      // 1. Sauvegarde des données (si nécessaire)
      // formKey.currentState?.save(); 

      // 2. Extraction des valeurs
      final title = titleController.text;
      final detail = detailController.text;
      final category = categoryController.text;
      final quantity = qteController.text;
      final price = priceController.text;
      
      // La logique métier d'enregistrement du produit irait ici.
      debugPrint('Produit enregistré: $title ($quantity $selectedUnit) @ $price');

    }
  }
  
  void resetForm() {
    titleController.clear();
    detailController.clear();
    categoryController.clear();
    qteController.clear();
    priceController.clear();
    // _selectedImagePath = null;
    _selectedUnit = "KG";
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    detailController.dispose();
    categoryController.dispose();
    qteController.dispose();
    priceController.dispose();
    super.dispose();
  }
}