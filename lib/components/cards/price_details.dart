import 'package:flutter/material.dart';

class PriceDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const PriceDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    // Style par défaut pour les lignes non-Total (fin, petite taille, gris léger)
    const defaultStyle = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 11,
      fontWeight: FontWeight.w500, // Normal/Light
      color: Colors.black,
    );

    // Style pour la ligne Total (Gras, même taille ou légèrement plus grande)
    const totalStyle = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 11, // La taille reste la même que les autres lignes
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- 1. Label (Prix, Livraison, Discoute, Total) ---
          Text(
            label,
            style: isTotal ? totalStyle : defaultStyle,
          ),
          
          // --- 2. Valeur (4000 F, 500 F, etc.) ---
          Text(
            value,
            style: isTotal ? totalStyle : defaultStyle,
          ),
        ],
      ),
    );
  }
}