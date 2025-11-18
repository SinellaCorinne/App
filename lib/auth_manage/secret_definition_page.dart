import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/auth_manage/confirmation_code_page.dart';
import 'package:noworry_app/components/forms/pin_code_box.dart';
import 'package:noworry_app/components/ui/button.dart';
import 'package:noworry_app/theme/styles.dart';

class SecretCodeDefinitionPage extends StatefulWidget {
  const SecretCodeDefinitionPage({super.key});

  @override
  State<SecretCodeDefinitionPage> createState() => _SecretCodeDefinitionPageState();
}

class _SecretCodeDefinitionPageState extends State<SecretCodeDefinitionPage> {
  // Contrôleurs pour les 4 chiffres du code
  final List<TextEditingController> _codeControllers = 
      List.generate(4, (_) => TextEditingController());
      
  // ✅ NOUVEAU : FocusNodes pour gérer l'état de focus des champs
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
      
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Ajout des listeners pour forcer le rebuild lorsque le focus change,
    // afin que PinCodeTextField puisse mettre à jour la couleur de sa bordure.
    for (var node in _focusNodes) {
      node.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    // Suppression des listeners avant de disposer
    for (var node in _focusNodes) {
      node.removeListener(() => setState(() {})); 
      node.dispose();
    }
    _codeControllers.forEach((c) => c.dispose());
    super.dispose();
  }

  void _submitCode(AppLocalizations l) {
    String secretCode = _codeControllers.map((c) => c.text).join();
    
    if (secretCode.length == 4) { 
      print("Code Secret défini: $secretCode");
      
      // Exemple de navigation vers la page suivante
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const  ConfirmationCodePage()));
    } else {
      showAlertCard(context, "Veuillez définir un code de 4 chiffres.");

      
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
                Text(
                  "Erreur",
                  style: const TextStyle(
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

  // ✅ NOUVEAU : Fonction de rappel pour la navigation automatique
  void _onCodeChanged(String value, int index) {
    if (value.length == 1) {
      // Passer au champ suivant si le caractère est entré
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus(); // Masquer le clavier après le dernier chiffre
      }
    } else if (value.isEmpty && index > 0) {
      // Revenir au champ précédent si l'utilisateur efface
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    
    // Forcer le rebuild pour mettre à jour l'état visuel (isFilled/isFocused)
    setState(() {}); 
  }

  // L'ancien widget _codeField est maintenant inutile, remplacé par PinCodeTextField

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
              const SizedBox(height: 60),
              
              // --- Titre ---
              Text(
                l.secretCodeTitle.toUpperCase(),
                style: KTypography.h5(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold), 
              ),
              const SizedBox(height: 15),
              
              // --- Instruction ---
              Text(
                l.secretCodeInstruction, 
                style: KTypography.h5(context, ),
              ),
              const SizedBox(height: 50),

              // --- Champs de Saisie du Code Secret (4 carrés) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // Utilisation du composant PinCodeTextField
                children: List.generate(4, (index) {
                    final bool isFilled = _codeControllers[index].text.isNotEmpty;
                    final bool isFocused = _focusNodes[index].hasFocus;
                    
                    return PinCodeTextField(
                      key: ValueKey(index),
                      controller: _codeControllers[index],
                      focusNode: _focusNodes[index],
                      isFilled: isFilled,
                      isFocused: isFocused,
                      onChanged: (value) => _onCodeChanged(value, index),
                    );
                }), 
              ),
              
              const SizedBox(height: 100),
              
              // --- Bouton Continuer ---
              Button(
                onPressed: () => _submitCode(l),
                backgroundColor: AppColors.primary,
                borderColor: AppColors.primary,
                foregroundColor: Colors.white, 
                child: Text(
                  l.continueButton, 
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
}