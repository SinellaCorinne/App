

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:noworry_app/auth_manage/Confirmation_page.dart';
import 'package:noworry_app/components/forms/pin_code_box.dart';
import 'package:noworry_app/components/ui/button.dart';
import 'package:noworry_app/theme/styles.dart';

class NewSecretCodePage extends StatefulWidget {
  const NewSecretCodePage({super.key});

  @override
  State<NewSecretCodePage> createState() => _NewSecretCodePageState();
}

class _NewSecretCodePageState extends State<NewSecretCodePage> {
  final int _codeLength = 4;
  
  //  Liste de contrôleurs et de FocusNodes
  final List<TextEditingController> _codeControllers = 
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = 
      List.generate(4, (_) => FocusNode());

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
    
    // Afficher le clavier nativement au chargement de la page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes.first);
    });
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

  // Logique de changement et de navigation entre les champs
  void _onCodeChanged(String value, int index) {
      if (value.length == 1) {
          // Passer au champ suivant si le caractère est entré
          if (index < _codeLength - 1) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else {
            FocusScope.of(context).unfocus(); // Masquer le clavier après le dernier chiffre
          }
      } else if (value.isEmpty) {
          // Revenir au champ précédent si l'utilisateur efface
          if (index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
      }
      
      // Forcer le rebuild pour mettre à jour l'état visuel (isFilled/isFocused)
      setState(() {}); 
  }

  void _submitCode(AppLocalizations l) {
    // Récupérer le code en joignant le texte de tous les contrôleurs
    String newSecretCode = _codeControllers.map((c) => c.text).join();
    
    if (newSecretCode.length == _codeLength) { 
      print("Nouveau Code Secret défini: $newSecretCode");
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationPage(initialSecretCode: newSecretCode),
        ),
      );
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
    final l = AppLocalizations.of(context)!;
    final isCodeComplete = _codeControllers.every((c) => c.text.length == 1); 

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              
              const SizedBox(height: 60),
              
              // --- Titre ---
              Text(
                l.newSecretCodeTitle.toUpperCase(),
                style: KTypography.h5(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold), 
              ),
              const SizedBox(height: 10),
              
              // --- Instruction ---
              Text(
                l.newSecretCodeInstruction,
                style: KTypography.h5(context, ),
              ),
              const SizedBox(height: 40),

              // --- Carrés d'Affichage du Code Secret (Utilisation PinCodeTextField) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_codeLength, (index) {
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
              
              const SizedBox(height: 120),
              
              // --- Bouton Continuer ---
              Button(
                onPressed: isCodeComplete ? () => _submitCode(l) : null,
                backgroundColor: AppColors.primary,
                borderColor: AppColors.primary,
                foregroundColor: Colors.white,
                child: Text(
                  l.continueButton, 
                  style: KTypography.h6(context,color: Colors.white )?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40), 
            ],
          ),
        ),
      );
  }
}