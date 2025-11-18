import 'package:flutter/material.dart';

// Définition des couleurs pour la démo (ajustez selon votre styles.dart)
class AppColors {
  // Couleur verte pour les encaissements
  static const Color successGreen = Color(0xFF388E3C); 
  // Gris clair pour la bordure et le texte de détail
  static const Color accent = Color(0xFFE0E0E0); 
}

class TransactionHistoryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String productLabel;
  final String productName;
  final String referenceLabel;
  final String referenceValue;

  const TransactionHistoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.productLabel,
    required this.productName,
    required this.referenceLabel,
    required this.referenceValue,
  });

  @override
  Widget build(BuildContext context) {
    // Style pour les textes principaux
    final textTheme = Theme.of(context).textTheme;

    return Container(
      // Marge extérieure
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      
      // Décoration du Container (Fond blanc, bordure légère)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. Titre et Montant de la Transaction ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title, // Ex: Encaissement
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.successGreen, // Titre en vert
                ),
              ),
              Text(
                amount, // Ex: + 34,680 F
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.successGreen, // Montant en vert
                ),
              ),
            ],
          ),
          
          // --- Ligne de séparation ---
          const Divider(height: 20, thickness: 1, color: AppColors.accent),
          
          // --- 2. Détail Produit ---
          _buildDetailRow(
            context,
            productLabel, // Ex: Produit
            productName, // Ex: Salade fruite
          ),
          
          // --- 3. Détail Référence ---
          _buildDetailRow(
            context,
            referenceLabel, // Ex: Référence
            referenceValue, // Ex: QWt90FGH0p334
          ),
        ],
      ),
    );
  }

  // Widget utilitaire pour les lignes de détails
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    // Style pour le label (gris, petit)
    final labelStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Colors.grey.shade600,
    );
    
    // Style pour la valeur (noir, plus petit que le titre)
    final valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: labelStyle,
          ),
          Text(
            value,
            style: valueStyle,
          ),
        ],
      ),
    );
  }
}

/** Dans votre widget parent (ex: Scaffold body)
TransactionHistoryCard(
  title: 'Encaissement',
  amount: '+ 34,680 F',
  productLabel: 'Produit',
  productName: 'Salade fruite',
  referenceLabel: 'Référence',
  referenceValue: 'QWt90FGH0p334',
) */