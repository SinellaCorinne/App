import 'package:flutter/material.dart';
import 'package:noworry_app/auth_manage/login_page.dart';
import 'package:noworry_app/components/forms/pin_code_box.dart';
import 'package:noworry_app/components/ui/button.dart';
import 'package:noworry_app/theme/styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class ConfirmationCodePage extends StatefulWidget {
  final String? initialSecretCode; 
  
  const ConfirmationCodePage({super.key, this.initialSecretCode});

  @override
  State<ConfirmationCodePage> createState() => _ConfirmationCodePageState();
}

class _ConfirmationCodePageState extends State<ConfirmationCodePage> {
  final int _codeLength = 4;
  
  // Contrôleurs pour les 4 chiffres du code
  final List<TextEditingController> _codeControllers = 
      List.generate(4, (_) => TextEditingController());
      
  //  FocusNodes pour gérer l'état de focus des champs
  final List<FocusNode> _focusNodes = 
      List.generate(4, (_) => FocusNode());
      
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Ajout des listeners pour forcer le rebuild lorsque le focus change
    for (var node in _focusNodes) {
      node.addListener(() {
        if (mounted) setState(() {});
      });
    }
    // Demander le focus sur le premier champ au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes.first);
    });
  }

  @override
  void dispose() {
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
          if (index < _codeLength - 1) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else {
            FocusScope.of(context).unfocus(); 
          }
      } else if (value.isEmpty) {
          if (index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
      }
      
      // Force le rebuild pour mettre à jour l'état visuel (isFilled/isFocused)
      setState(() {}); 
  }

  void _confirmCode(AppLocalizations l) {
    // Récupérer le code en joignant le texte de tous les contrôleurs
    String confirmationCode = _codeControllers.map((c) => c.text).join();
    
    if (confirmationCode.length == 4) { 
      // Logique de vérification (si le code initial est passé)
      if (widget.initialSecretCode != null && confirmationCode != widget.initialSecretCode) {
          showAlertCard(context,("Les codes ne correspondent pas.")
         );
         return;
      }
     
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      
    } else {
     
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                  
                    style: ElevatedButton.styleFrom(
                     minimumSize: const Size(300, 55),
                          padding: 
                            const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                          
                      backgroundColor: Colors.red[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
    // Vérifie si tous les contrôleurs ont un caractère
    final isCodeComplete = _codeControllers.every((c) => c.text.length == 1);

    return Scaffold(
      
      appBar: AppBar(        // couleur fixe
  surfaceTintColor: Colors.transparent,  // empêche le tint M3
  elevation: 0,  
        centerTitle: true,
        title: Text(
          l.onafaliTitle, 
          style: KTypography.h1(context, )?.copyWith(fontWeight: FontWeight.bold),
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
                l.confirmCodeTitle.toUpperCase(),
                style: KTypography.h5(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold), 
              ),
              const SizedBox(height: 15),
              
              // --- Instruction ---
              Text(
                l.confirmCodeInstruction,
                style: KTypography.h5(context, ),
              ),
              const SizedBox(height: 50),

              // --- Champs de Saisie du Code Secret (Utilisation PinCodeTextField) ---
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
                onPressed: isCodeComplete ? () => _confirmCode(l) : null,
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
      ),
    );
  }
}