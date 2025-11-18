import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noworry_app/theme/styles.dart';


class PinCodeTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  
  // Ces paramètres déterminent l'apparence de la bordure
  final bool isFilled;
  final bool isFocused;

  const PinCodeTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    required this.isFilled,
    required this.isFocused,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Définition des caractéristiques de bordure (basées sur votre PinCodeBox)
    // Ces variables sont utilisées directement dans l'InputDecoration.
    final Color borderColor = isFilled || isFocused ? AppColors.primary : AppColors.grayL;
    final double borderWidth = isFocused ? 2.5 : 2.0;

    return SizedBox(
      width: 51,
      height: 51, // Augmenté pour donner plus d'espace et faciliter le centrage
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center, // Centre le texte horizontalement
    
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        
        // Caractéristiques pour l'affichage du point masqué
        obscuringCharacter: '•',
        // Masque si le champ est rempli (isFilled = controller.text.isNotEmpty)
        obscureText: isFilled, 
        
        // Style du texte tapé (ou du point masqué)
        style: KTypography.h3(context, color: AppColors.grayD),
        
        // ✅ CORRECTION MAJEURE : La décoration est entièrement gérée par InputDecoration
        decoration: InputDecoration(
          // Centrer le texte verticalement.
          // La valeur exacte peut nécessiter un léger ajustement selon la police.
          contentPadding: const EdgeInsets.only(bottom: 0, top: 0), // Ajustez ces valeurs
          
          filled: true,
          fillColor: Colors.white,
          
          // Bordure quand le champ est actif (focus)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.primary, width: 2.5),
          ),
          
          // Bordure par défaut (quand le champ est enabled mais sans focus)
          // La couleur et l'épaisseur varient selon isFilled
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          
          // Bordure générale (utilisée pour 'border' si d'autres ne sont pas spécifiées)
          // Nous la définissons pour être cohérente
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
        ),
        
        onChanged: onChanged,
      ),
    );
  }
}