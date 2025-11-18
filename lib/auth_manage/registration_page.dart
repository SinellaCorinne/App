import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/auth_manage/phone.dart';
import 'package:noworry_app/components/ui/button.dart';
import 'package:noworry_app/components/ui/text_label.dart';
import 'package:noworry_app/theme/styles.dart'; 
// Assurez-vous d'importer la page de destination (ex: Telephone)
// import 'telephone.dart'; 

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedCountryCode ="SN";

  // Liste simple de pays (à adapter/compléter)
  final List<Map<String, String>> _countries = [
    {'code': 'SN', 'name': 'Sénégal', 'flag': '🇸🇳'},
    {'code': 'ML', 'name': 'Mali', 'flag': '🇲🇱'},
    {'code': 'BF', 'name': 'Burkina Faso', 'flag': '🇧🇫'},
    {'code': 'CI', 'name': 'Côte d\'Ivoire', 'flag': '🇨🇮'},
  ];

  void _submitForm() {
    // Valide le formulaire et vérifie si le pays est sélectionné
    if (_formKey.currentState!.validate() && selectedCountryCode != null) {
     
      
      // Exemple de navigation (vers la page de téléphone)
       Navigator.push(context, MaterialPageRoute(builder: (context) => const Telephone()));
    } else {
       // Affiche le message d'erreur du sélecteur si le pays manque
       if (selectedCountryCode == null) {
        showAlertCard(context, AppLocalizations.of(context)!.countryRequiredError);
        
       }
    }
  }
  void showAlertCard(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: true, // Ferme en cliquant à l'extérieur
    builder: (BuildContext context) {
      return Center(
        child: Material(
          color: Colors.transparent, // Fond transparent
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 40,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Erreur",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Source Sans Pro",
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    // ✅ Utilisation du vrai AppLocalizations
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
                 // couleur fixe
  surfaceTintColor: Colors.transparent,  // empêche le tint M3
  elevation: 0,  
        centerTitle: true,
        title: Text(
          l.onafaliTitle, // Traduit
          style: KTypography.h1(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold),
        ),
    
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // --- 1. Champ Nom ---
              TextLabel(text:l.nameLabel,), // Traduit
              TextFieldCompose(hint:l.enterNameHint, requiredError: l.fieldRequiredError), // Traduit
              const SizedBox(height: 20),

              // --- 2. Champ Prénoms ---
              TextLabel(text:l.firstNameLabel, ), // Traduit
              TextFieldCompose(hint:l.enterFirstNameHint, requiredError:l.fieldRequiredError), // Traduit
              const SizedBox(height: 20),
              
              // --- 3. Sélecteur de Pays ---
             TextLabel(text:l.countryLabel, ), // Traduit
              _buildCountrySelector(l), // Passe l'instance de traduction
              
              const SizedBox(height: 60),
              
              // --- 4. Bouton Continuer ---
              Button(
                onPressed: _submitForm,
                backgroundColor: AppColors.primary,
                borderColor: AppColors.primary,
                foregroundColor: Colors.white, 
                child: Text(
                  l.continueButton, // Traduit
                  style: KTypography.h6(context, color: Colors.white)?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }



  // ✅ Passe l'instance de localisation pour la traduction des messages d'erreur et des hints
  Widget _buildCountrySelector(AppLocalizations l) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      value: selectedCountryCode,
      hint: Text(l.selectCountryHint), // Traduit
      onChanged: (String? newValue) {
        setState(() {
          selectedCountryCode = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return l.countryRequiredError; // Traduit
        }
        return null;
      },
      items: _countries.map((Map<String, String> country) {
        return DropdownMenuItem<String>(
          
          value: country['code'],
          child: Row(
            children: [
              Text(country['flag']!, style: const TextStyle(fontSize: 20)), 
              const SizedBox(width: 10),
              Text(country['name']!,style: KTypography.h6(context,)?.copyWith(fontWeight: FontWeight.w600) ,),
            ],
          ),
        );
      }).toList(),
    );
  }
}