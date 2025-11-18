// Fichier : lib/widgets/profile_option_tile.dart

import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';

class ProfileOptionTile extends StatelessWidget {
  final String label;
  final IconData? suffixIcon; // Flèche ou icône WhatsApp
  final VoidCallback onTap;
  

  const ProfileOptionTile({
    super.key,
    required this.label,
    this.suffixIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
         
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: KTypography.k9(context, )?.copyWith(fontWeight: FontWeight.w500)
              ),
              if (suffixIcon != null)
                Icon(
                  suffixIcon,
                  color: label.contains("assistance") ? AppColors.primary : Colors.black, // Vert pour WhatsApp
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}