import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';

class TextLabel extends StatelessWidget {
  final String text;

  const TextLabel({
    super.key,
    required this.text, // Le texte devient un paramètre requis
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: KTypography.h5(context, )?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

// -------------------------------------------------------------
// DEUXIÈME COMPOSANT : LE CHAMP DE SAISIE (TexteField)
// -------------------------------------------------------------
class TextFieldCompose extends StatelessWidget {
  final String hint;
  final String requiredError;

  const TextFieldCompose({
    super.key,
    required this.hint,
    required this.requiredError,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: KTypography.h6(context, )?.copyWith(
        fontWeight: FontWeight.normal,
      ),

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: KTypography.h6(context, color: AppColors.grayL),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),

        // 🔹 Bordure inactive
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.grayL,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),

        // 🔹 Bordure quand le champ est actif
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary, // ex. vert principal
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),

        // 🔹 Bordure par défaut (fallback)
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.grayL,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return requiredError;
        }
        return null;
      },
    );
  }
}
