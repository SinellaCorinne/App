import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';


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
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------ TITRE + MONTANT -----------------
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  amount,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // ------------ DIVIDER -----------------
          Divider(
            height: 12,
            thickness: 0.6,
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 4),

          // ------------ PRODUIT -----------------
          _buildDetailRow(context, productLabel, productName),

          // ------------ REFERENCE -----------------
          _buildDetailRow(context, referenceLabel, referenceValue),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // ROW REUTILISABLE
  // -------------------------------------------------------------
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        );

    final valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}