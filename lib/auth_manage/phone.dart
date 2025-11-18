import 'package:flutter/material.dart';
// ❌ Supprimez cet import : import 'package:intl_phone_field/intl_phone_field.dart'; 
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/auth_manage/verification_page.dart';
import 'package:noworry_app/components/ui/button.dart';// ✅ Votre nouveau composant
import 'package:noworry_app/components/ui/phone_field.dart';
import 'package:noworry_app/theme/styles.dart';

class Telephone extends StatefulWidget {
  const Telephone({super.key});

  @override
  State<Telephone> createState() => _TelephoneState();
}

class _TelephoneState extends State<Telephone> {
  String? fullPhoneNumber; 
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController(); // Contrôleur pour le champ

  void _submitNumber(AppLocalizations l) {
    // Le validator du MinimalPhoneField est maintenant beaucoup plus complet
    if (_formKey.currentState!.validate() && fullPhoneNumber != null) {
        print('Numéro de téléphone complet soumis : $fullPhoneNumber');
        
         Navigator.push(context, MaterialPageRoute(builder: (context) =>  VerificationPage(phoneNumber: fullPhoneNumber!)));
        
    } else {
      showAlertCard(context, l.emptyNumberError);
        // Le validator du champ affiche déjà un message, ce SnackBar est optionnel.
      
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
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!; 

    return Scaffold(
      appBar: AppBar(        // couleur fixe
  surfaceTintColor: Colors.transparent,  // empêche le tint M3
  elevation: 0,  
        centerTitle: true,
        title: Text(
          l.onafaliTitle, 
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
              const SizedBox(height: 120), // Espace ajusté
              
              Text(
                l.phoneNumberTitle, 
                style: KTypography.h6(context, )?.copyWith(fontWeight: FontWeight.w600), 
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              
              // ✅ Utilisation du nouveau composant
              MinimalPhoneField(
                controller: _phoneController, // Passage du contrôleur
                initialCountryCode: 'SN', 
                hintText: l.numberHint, 
                onChanged: (phoneNumberWithCode) {
                    // phoneNumberWithCode est la version nettoyée (sans espace)
                    fullPhoneNumber = phoneNumberWithCode;
                },
                // Le validator est maintenant entièrement dans le composant MinimalPhoneField
                validator: (value) {
                    // Ici, on ne met plus de validation manuelle pour éviter la duplication.
                    // On laisse le validator interne du MinimalPhoneField faire le travail.
                    if (value == null || value.isEmpty) {
                        return l.emptyNumberError;
                    }
                    return null;
                },
              ),
              const SizedBox(height: 40),
              
              // --- BOUTON CONTINUER ---
              Button(
                onPressed: () => _submitNumber(l), 
                backgroundColor: AppColors.primary,
                borderColor: AppColors.primary,
                foregroundColor: Colors.white,
                child: Text(
                  l.continueButton, 
                  style: KTypography.h6(context, color: Colors.white)?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}