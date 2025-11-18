import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';

// Définition de la couleur pour le suffixe pour la démo


class InputWithUnitSuffix extends StatelessWidget {
  final String hintText;
  final String unit; // Ex: KG
  final List<String> availableUnits; // Ex: ['KG', 'L', 'Pièce']
  final String? selectedUnit;
  final ValueChanged<String?> onUnitChanged;
  final TextEditingController? controller;
  final bool isQuantityInput; // Si c'est pour une quantité, utilise le clavier numérique

  const InputWithUnitSuffix({
    super.key,
    this.hintText = 'Écrivez votre prénom', // Texte par défaut de l'image
    this.unit = 'KG',
    this.availableUnits = const ['KG', 'L', 'Pièce'],
    this.selectedUnit,
    required this.onUnitChanged,
    this.controller,
    this.isQuantityInput = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // Hauteur standard
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: AppColors.grayL, width: 1),
      ),
      
      child: TextFormField(
        controller: controller,
        keyboardType: isQuantityInput ? TextInputType.number : TextInputType.text,
        style: const TextStyle(fontSize: 12),
        
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          isDense: true, 
          hintStyle: KTypography.h6(context, color: AppColors.grayL),

          
          // --- Suffixe Personnalisé (Unité + Dropdown) ---
          suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: Container(
            width: 50, // Largeur fixe pour le suffixe
            decoration: const BoxDecoration(
              // Fond gris clair pour le suffixe
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
              // Bordure gauche pour séparer le champ de l'unité
              border: Border(left: BorderSide(color: AppColors.grayL, width: 1.0)), 
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedUnit ?? unit,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20),
                style: const TextStyle(
                  color: Colors.black,
                  
                  fontSize: 12,
                ),
                dropdownColor: Colors.white,
                isExpanded: true,
                padding: EdgeInsets.zero,
                items: availableUnits.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                        )
                    ),
                  );
                }).toList(),
                onChanged: onUnitChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}