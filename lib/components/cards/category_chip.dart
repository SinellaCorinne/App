import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  // Détermine si c'est le chip spécial 'Tous' ou 'All'
  bool get isDropdown => label == 'Tous' || label == 'All';

  @override
  Widget build(BuildContext context) {
    // Couleur d'activation (Vert)
    const Color activeColor = AppColors.primary; 
    
    // Détermination de la couleur de bordure
    final Color borderColor;
    if (isDropdown) {
      borderColor = Colors.black; // Cas 1: 'Tous' est toujours encadré en noir
    } else {
      // Cas 2 & 3: Les autres sont encadrés en vert si sélectionnés, blanc/transparent sinon
      borderColor = isSelected ? activeColor : Colors.transparent; 
    }

    // Détermination de la couleur du texte
    final Color textColor;
    if (isDropdown) {
      textColor = Colors.black87; // Cas 1: Texte noir pour 'Tous'
    } else {
      // Cas 2 & 3: Texte vert si sélectionné, gris foncé sinon
      textColor = isSelected ? activeColor : Colors.grey.shade800;
    }
    
    // Détermination de la couleur de fond
    final Color backgroundColor =  Colors.transparent;


    return InkWell(
      borderRadius: BorderRadius.circular(2),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(2), // Ajout de borderRadus ici
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Utilisation du même style de texte pour éviter la duplication
            Text(
              label,
              style: TextStyle(
                fontFamily: isDropdown ? "Sen" : 'Sen', // Garder la police 'Sen'
                fontSize: 15,
                color: textColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
            
            // L'icône déroulante est seulement pour 'Tous'
            if (isDropdown) ...[
              const SizedBox(width: 2),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black87, // L'icône reste noire pour 'Tous'
                size: 19,
              ),
            ],
           
          ],
        ),
      
      ),
      
    );
    
  }
}