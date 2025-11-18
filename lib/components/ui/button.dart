


import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color foregroundColor;

  const Button({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.borderColor = AppColors.primary,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        // ✅ Couleur de fond forcée
        backgroundColor: WidgetStateProperty.all(backgroundColor),

        // ✅ Couleur du texte forcée
        foregroundColor: WidgetStateProperty.all(foregroundColor),

        // ✅ Bordure
        side: WidgetStateProperty.all(BorderSide(color: borderColor, width: 1)),

        // ✅ Coins arrondis
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        // ✅ Taille et padding
        minimumSize: WidgetStateProperty.all(const Size(270, 55)),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        ),

        // ✅ Élévation
        elevation: WidgetStateProperty.all(0),
      ),
      child: child,
    );
  }
}
