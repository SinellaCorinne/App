import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/auth_manage/secret_definition_page.dart';
import 'package:noworry_app/components/forms/pin_code_box.dart'; 
import 'package:noworry_app/components/ui/button.dart';
import 'package:noworry_app/theme/styles.dart'; 
import 'dart:async';

class VerificationPage extends StatefulWidget {
  // Le numéro de téléphone complet est passé à cette page
  final String phoneNumber; 
  
  const VerificationPage({super.key, required this.phoneNumber});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  // Contrôleurs pour chaque champ de saisie OTP
  final List<TextEditingController> _otpControllers = 
      List.generate(5, (_) => TextEditingController());
      
  final int _resendSeconds = 60; // Durée du compte à rebours
  late int _currentSeconds;
  Timer? _timer;
  void _onOtpChanged(String value, int index) {
      if (value.length == 1) {
          // Si un caractère est tapé et ce n'est pas le dernier champ, passer au suivant
          if (index < 4) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }
      } else if (value.isEmpty) {
          // Si le champ est vidé, revenir au champ précédent
          if (index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
      }
       setState(() {});
       }
      
      // Forcer le rebuild pour mettre à jour l'apparence des PinCodeTextFields (isFilled/isFocused)
     
  // Utilisation d'un FocusNode pour gérer le focus entre les champs
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _currentSeconds = _resendSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _otpControllers.forEach((c) => c.dispose());
    _focusNodes.forEach((f) => f.dispose());
    _timer?.cancel();
    super.dispose();
  }
  
  // --- Gestion du Compte à Rebours ---
  void _startTimer() {
    _currentSeconds = _resendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _currentSeconds--;
        });
      }
    });
  }

  void _resendCode() {
    if (_currentSeconds == 0) {
      // TODO: Implémenter l'appel API pour renvoyer le code
      _startTimer();
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

  void _verifyNumber(AppLocalizations l) {
    String otp = _otpControllers.map((c) => c.text).join();
    
    if (otp.length == 5) { // Si le code est de 5 chiffres
      
      // Exemple de navigation après succès
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SecretCodeDefinitionPage()));
    } else {
    showAlertCard(context, "Veuillez entrer un code de vérification complet.");

    }
  }

  // Obtient les 4 derniers chiffres du numéro pour l'affichage masqué
  String get _lastDigits => widget.phoneNumber.length >= 4 
      ? widget.phoneNumber.substring(widget.phoneNumber.length - 4) 
      : "XXXX";


  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final String timerText = "${_currentSeconds ~/ 60}:${(_currentSeconds % 60).toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(         // couleur fixe
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
            const SizedBox(height: 70),
            
            // --- Titre ---
            Text(
              l.verificationCodeTitle.toUpperCase(),
              style: KTypography.h5(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold), // En vert
            ),
            const SizedBox(height: 10),
            
            // --- Instruction (Numéro masqué) ---
            Text(
              l.verificationInstruction(_lastDigits), // Traduit avec placeholder
              style: KTypography.h5(context, ),
            ),
            const SizedBox(height: 40),

            // --- Champs de Saisie OTP ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                // Déterminer les états à passer au composant réutilisable
                final bool isFilled = _otpControllers[index].text.isNotEmpty;
                final bool isFocused = _focusNodes[index].hasFocus;
                
                return PinCodeTextField(
                  key: ValueKey(index), // Clé recommandée pour les éléments de liste
                  controller: _otpControllers[index],
                  focusNode: _focusNodes[index],
                  isFilled: isFilled,
                  isFocused: isFocused,
                  onChanged: (value) => _onOtpChanged(value, index),
                );
              } ),
            ),
            const SizedBox(height: 10),

            // --- Renvoi du Code et Compte à Rebours ---
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _resendCode,
                  child: Text(
                    l.resendCodeLabel, // Traduit
                    style: KTypography.h5(context,),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  timerText, // Affiche le compte à rebours (00:00)
                  style: KTypography.h5(context, color: AppColors.primary,)?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            
            const SizedBox(height: 60),
            
            // --- Bouton de Vérification ---
            Button(
              onPressed: () => _verifyNumber(l),
              backgroundColor: AppColors.primary,
              borderColor: AppColors.primary,
              foregroundColor: Colors.white, 
              child:  Text(
                l.verifyNumberButton, // Traduit
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