

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:noworry_app/auth_manage/reset_secret_page.dart';
import 'package:noworry_app/auth_manage/role_page.dart';
import 'package:noworry_app/components/ui/button.dart';
import 'package:noworry_app/theme/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final int _codeLength = 4;

  @override
  void initState() {
    super.initState();
    // Reconstruit l'UI chaque fois que le texte change pour mettre à jour les carrés
    _pinController.addListener(() => setState(() {}));
    
    // Afficher le clavier nativement au démarrage de la page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_pinFocusNode);
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _verifyCode(AppLocalizations l) {
    String secretCode = _pinController.text;
    
    if (secretCode.length == _codeLength) { 
      // TODO: Implémenter l'appel API pour vérifier le code
      print("Tentative de connexion avec le code: $secretCode");
      
      // Exemple de navigation après succès
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => // Home()
      RoleSelectionScreen()));
    } else {
      showAlertCard(context, "Veuillez entrer un code de 4 chiffres.");
     
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


  // --- Widget pour un seul carré d'affichage du PIN ---
  Widget _codeDisplayBox(int index) {
    bool isFilled = index < _pinController.text.length;
    bool isFocused = _pinFocusNode.hasFocus && index == _pinController.text.length;

    return Container(
      width: 51,
      height: 41,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          // La bordure est verte si remplie ou si c'est le champ actif
          color: isFilled || isFocused ? AppColors.primary : AppColors.grayL, 
          width: isFocused ? 2.5 : 2.0, // Plus épais si actif
        ),
        color: Colors.white,
      ),
      child: isFilled
          ? Text(
              '•', // Le point pour masquer le chiffre
              style: KTypography.h3(context, color: AppColors.grayD),
            )
          : const SizedBox.shrink(),
    );
  }


  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isCodeComplete = _pinController.text.length == _codeLength;

    return Scaffold(
      
      
      body: GestureDetector(
        // Permet de cliquer n'importe où pour refaire apparaître le clavier
        onTap: () => FocusScope.of(context).requestFocus(_pinFocusNode),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height:29 ),
             
              // --- Champ de saisie invisible ---
              SizedBox(
                width: 0, 
                height: 0, 
                child: TextField(
                  controller: _pinController,
                  focusNode: _pinFocusNode,
                  keyboardType: TextInputType.number, // ✅ Clavier numérique natif
                  autofocus: true,
                  obscureText: true,
                  maxLength: _codeLength,
                  // Rendre le champ et son contenu invisible
                  decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
                  style: const TextStyle(color: Colors.transparent), 
                  cursorColor: Colors.transparent, 
                ),
              ),
              
              // --- Badge "Besoin d'aide?" (en haut à gauche) ---
            Align(
  alignment: Alignment.centerLeft,
  child: Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.grayL),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/image.png', 
          width: 18, 
          height: 18,
          color: AppColors.grayD, 
        ),
        const SizedBox(width: 4),
        Text(
          l.needHelp,
          style: KTypography.h6(context, )?.copyWith(decoration: TextDecoration.underline,),
        ),
      ],
    ),
  ),
),

              const SizedBox(height: 60),
              
              // --- Instruction ---
               SizedBox(height: 20,),
              Center(
                child: Text(
                          l.onafaliTitle, 
                          style: KTypography.h1(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold),
                        ),
              ),
               SizedBox(height: 30,),
              Center(
                child: Text(
                  l.enterSecretCode, 
                  style: KTypography.h6(context, ),
                ),
              ),
              const SizedBox(height: 20),

              // --- Carrés d'Affichage du Code Secret ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_codeLength, (index) => _codeDisplayBox(index)), 
              ),
              const SizedBox(height: 30),
              
              // --- Lien "J'ai oublié mon code" ---
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Logique de récupération de code
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ResetSecretCodePage()));
                  },
                  child: Text(
                    l.forgotCode, 
                    style: KTypography.h5(context, )?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // --- Bouton Continuer ---
              Button(
                onPressed: isCodeComplete ? () => _verifyCode(l) : null,
                backgroundColor: AppColors.primary,
                borderColor: AppColors.primary,
                foregroundColor: Colors.white, 
                child: Text(
                  l.continueButton, 
                  style: KTypography.h6(context,color: Colors.white )?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              
            ],
          ),
        ),
      ),
    );
  }
}