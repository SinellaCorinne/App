import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/auth_manage/new_secret_page.dart';
import 'package:noworry_app/components/forms/pin_code_box.dart';
import 'package:noworry_app/components/ui/button.dart';
import 'package:noworry_app/theme/styles.dart';

class ResetSecretCodePage extends StatefulWidget {
  final String? phoneNumberSuffix;
  const ResetSecretCodePage({super.key, this.phoneNumberSuffix = "9807"});

  @override
  State<ResetSecretCodePage> createState() => _ResetSecretCodePageState();
}

class _ResetSecretCodePageState extends State<ResetSecretCodePage> {
  
  // ✅ NOUVEAU : Listes pour les contrôleurs et les FocusNodes (5 éléments)
  final List<TextEditingController> _codeControllers = 
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
      
  final int _codeLength = 5;
  final int _resendSeconds = 60;
  late int _currentSeconds = _resendSeconds;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    // Ajout d'un listener pour chaque FocusNode pour forcer le rebuild
    for (var node in _focusNodes) {
      node.addListener(() {
        if (mounted) setState(() {});
      });
    }
    _startResendTimer();
    // Demander le focus sur le premier champ au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes.first);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeControllers.forEach((c) => c.dispose());
    for (var node in _focusNodes) {
      node.removeListener(() => setState(() {})); 
      node.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() {
      _currentSeconds = _resendSeconds;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_currentSeconds == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() => _currentSeconds--);
      }
    });
  }

  void _verifyCode(AppLocalizations l) {
    // Joindre le texte des 5 contrôleurs
    String verificationCode = _codeControllers.map((c) => c.text).join();
    
    if (verificationCode.length == _codeLength) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NewSecretCodePage()));
    } else {
      showAlertCard(context, l.fieldRequiredError);
     
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


  // ✅ NOUVEAU : Logique de changement et de navigation entre les champs
 void _onCodeChanged(String value, int index) {
  if (value.length == 1) {
    // Si un caractère est tapé et ce n'est pas le dernier champ, passer au suivant
    if (index < _codeLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      FocusScope.of(context).unfocus(); // Masquer le clavier si le dernier est rempli
    }
  } else if (value.isEmpty) {
    // Si le champ est vidé, revenir au champ précédent
    if (index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  // Rebuild nécessaire pour mettre à jour l'état visuel (bordure verte/remplie)
  setState(() {});

  // 🔥 Vérification automatique une fois tous les champs remplis
  String currentCode = _codeControllers.map((c) => c.text).join();
  if (currentCode.length == _codeLength) {
    _verifyCode(AppLocalizations.of(context)!);
  }
}
 // --- _codeDisplayBox est supprimé ---

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    
    // ✅ MODIFIÉ : Vérifie si tous les contrôleurs ont un caractère
    final isCodeComplete = _codeControllers.every((c) => c.text.length == 1); 
    
    final minutes = (_currentSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_currentSeconds % 60).toString().padLeft(2, '0');
    final formattedResendTime = l.resendCodeTimer(minutes, seconds);

    return Scaffold(
      appBar: AppBar(        // couleur fixe
  surfaceTintColor: Colors.transparent,  // empêche le tint M3
  elevation: 0,  
        centerTitle: true,
        title: Text(
          l.onafaliTitle,
          style: KTypography.h1(context, color: AppColors.primary)
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        
      ),
      body: SingleChildScrollView( // Le GestureDetector parent n'est plus nécessaire
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              // L'ancien Champ invisible est supprimé
              const SizedBox(height: 60),
              
              Text(l.resetCodeTitle.toUpperCase(),
                  style: KTypography.h5(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              
              Text(
                l.verificationInstruction(widget.phoneNumberSuffix ?? "9807"),
                style: KTypography.h5(context, ),
              ),
              const SizedBox(height: 40),
              
              // --- Champs de Saisie OTP (Utilisation du PinCodeTextField) ---
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
              
              const SizedBox(height: 20),
              InkWell(
                onTap: _canResend ? _startResendTimer : null,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: l.resendCodeLabel,
                    style: KTypography.h6(context,
                            color:
                                _canResend ? AppColors.primary : AppColors.grayL)
                        ?.copyWith(
                            decoration: _canResend
                                ? TextDecoration.underline
                                : TextDecoration.none),
                  ),
                  if (!_canResend)
                    TextSpan(
                      text: ' $formattedResendTime',
                      style: KTypography.h6(context, color: AppColors.primary)
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                ])),
              ),
              const SizedBox(height: 80),
              Button(
                onPressed: isCodeComplete ? () => _verifyCode(l) : null,
                backgroundColor: AppColors.primary,
                borderColor: AppColors.primary,
                foregroundColor: Colors.white,
                child: Text(l.continueButton,
                    style: KTypography.h6(context,color: Colors.white )
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    
  }
}