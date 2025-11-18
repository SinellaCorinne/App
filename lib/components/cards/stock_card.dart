
import 'package:flutter/material.dart';
import 'package:noworry_app/grossistes/pages/product/product_page.dart';
import 'package:noworry_app/theme/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Product {
  final String id;
  final String? nameKey;         // clé ARB pour le nom (optionnelle)
  final String? descriptionKey;  // clé ARB pour la description (optionnelle)
  final String name;             // fallback si pas de clé
  final String description;      // fallback si pas de clé
  final double stockQuantity;
  final String stockUnit;
  final String price;
  final String priceUnit;
  final bool isInStock;
  final String category;

  Product({
    required this.id,
    this.nameKey,
    this.descriptionKey,
    required this.name,
    required this.description,
    required this.stockQuantity,
    required this.stockUnit,
    required this.price,
    required this.priceUnit,
    required this.isInStock,
    required this.category,
  });
}

class ProductOverviewCard extends StatelessWidget {
  final Product product;
  final ValueChanged<bool> onToggleStock;
  final VoidCallback onEdit;

  const ProductOverviewCard({
    super.key,
    required this.product,
    required this.onToggleStock,
    required this.onEdit,
  });

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.grey.shade700,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    // Récupérer le texte traduit si la clé existe, sinon fallback
    String getTranslatedText(String? key, String fallback) {
      if (key == null) return fallback;
      switch (key) {
        case 'productOriginalSaladName':
          return l.productOriginalSaladName;
        case 'productOriginalSaladDescription':
          return l.productOriginalSaladDescription;
        default:
          return fallback;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ----- TITRE + BOUTON EDIT -----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslatedText(product.nameKey, product.name),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                ),
                GestureDetector(
                  onTap: onEdit,
                  child: Image.asset(
                    "assets/images/edit.png",
                    height: 15,
                    width: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            // ----- DESCRIPTION -----
            Text(
              getTranslatedText(product.descriptionKey, product.description),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Divider(height: 15, thickness: .9, color: Colors.grey.shade300),
            // ----- DETAILS -----
            _buildDetailRow(
              context,
              l.labelStock,
              "${product.stockQuantity.toStringAsFixed(0)} ${product.stockUnit}",
            ),
            _buildDetailRow(
              context,
              l.labelPrice,
              "${product.price} ${product.priceUnit}",
            ),
            // ----- SWITCH -----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l.labelInStock,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
                Transform.scale(
                  scale: 0.60,
                  child: Switch(
                    padding: const EdgeInsets.only(right: -15),
                    value: product.isInStock,
                    onChanged: onToggleStock,
                    activeColor: AppColors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // ----- VOIR LE PRODUIT -----
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(productId: product.id),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/see.png',
                    height: 15,
                    width: 15,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l.viewProduct,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
