// Fichier : lib/pages/profil/personal_info_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalInfoController extends ChangeNotifier {
  // --- Données Utilisateur Mockées ---
  // Dans une vraie application, ces données viendraient d'un service (ex: Firestore)
  final String _initialFirstName = "Wakiou";
  final String _initialLastName = "Farr";
  final String _initialPhoneNumber = "+22170908900"; // Numéro de téléphone non modifiable

  // --- Contrôleurs d'Entrée (Gérés ici) ---
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(); // Lecture seule
  final TextEditingController addressController = TextEditingController();


  PersonalInfoController() {
    // Initialiser les contrôleurs au chargement
    firstNameController.text = _initialFirstName;
    lastNameController.text = _initialLastName;
    phoneController.text = _initialPhoneNumber;
    addressController.text = "123 Rue de la Liberté, Dakar"; // Exemple d'adresse initiale
    
    // Écouter les changements pour des validations futures si nécessaire
    firstNameController.addListener(notifyListeners);
    lastNameController.addListener(notifyListeners);
    addressController.addListener(notifyListeners);
  }

  // --- Getters pour l'affichage ---
  String get currentFirstName => firstNameController.text;
  String get currentLastName => lastNameController.text;
  String get currentPhoneNumber => phoneController.text;
  
  // --- Logique d'Action ---

  void handleSave(BuildContext context, AppLocalizations l10n) {
     final newFirstName = firstNameController.text.trim();
     final newLastName = lastNameController.text.trim();
     final newAddress = addressController.text.trim();
     
     // 1. Logique de validation (simple)
     if (newFirstName.isEmpty || newLastName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur")),
        );
        return;
     }

     // 2. Logique de Sauvegarde (simulée)
     // Dans une vraie application: await UserService.update(newFirstName, newLastName, newAddress);

     debugPrint('Sauvegarde des informations: $newFirstName $newLastName, Adresse: $newAddress');

     // 3. Feedback utilisateur
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n.saveButton} réussi !')),
     );

     // notifyListeners(); // Si la sauvegarde mettait à jour l'état initial des champs, on appellerait notifyListeners()
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }
}