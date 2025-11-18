// Fichier : lib/pages/cart/cart_page.dart

import 'package:flutter/material.dart';
import 'package:noworry_app/clients/pages/panier/panier_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:noworry_app/components/cards/cart_item.dart'; // 💡 Import du CartItem mis à jour
import 'package:noworry_app/components/cards/price_details.dart';
import 'package:noworry_app/theme/styles.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fournit le contrôleur à la page
    return ChangeNotifierProvider<CartController>(
      create: (_) => CartController(),
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Écoute le contrôleur pour les changements (quantité, total, etc.)
    final controller = context.watch<CartController>();

    // Récupération des données d'affichage
    final subtotal = controller.subtotal;
    final total = controller.total;
    final priceUnit = l10n.priceUnit;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.cartTitle,
          style: KTypography.h4(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Iconsax.shopping_bag, color: Colors.black),
          ),
        ],
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. Liste des articles du panier ---
            ...controller.cartItems.map((item) {
              final localizedProductName = controller.getLocalizedProductName(l10n, item.id);
              
              return CartItem(
                productName: localizedProductName,
                restaurantName: item.restaurant,
                price: '${item.priceValue} $priceUnit',
                imageUrl: item.imageUrl,
                quantity: item.quantity, // 💡 Donnée d'état
                
                // 💡 Délègue l'action au contrôleur via le callback
                onQuantityChanged: (newQuantity) {
                  // Utilise context.read pour déclencher l'action du contrôleur
                  context.read<CartController>().updateQuantity(item, newQuantity);
                },
              );
            }),
            
            const SizedBox(height: 16),
            
            // --- 2. Détails du Prix ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD3D3D3), style: BorderStyle.solid, width: 0.5),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  PriceDetailRow(
                    label: l10n.priceLabel,
                    value: '$subtotal $priceUnit',
                  ),
                  PriceDetailRow(
                    label: l10n.deliveryLabel,
                    value: '${controller.deliveryCost} $priceUnit',
                  ),
                  PriceDetailRow(
                    label: l10n.discountLabel,
                    value: '${controller.discount} $priceUnit',
                  ),
                  const Divider(height: 24, color: AppColors.grayL),
                  PriceDetailRow(
                    label: l10n.totalLabel,
                    value: '$total $priceUnit',
                    isTotal: true,
                  ),
               
                  const SizedBox(height: 24),
                  
                  // --- 3. Boutons d'Action ---
                  Column(
                    children: [
                      // Payer à la livraison
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.handlePayment(context, l10n.payOnDeliveryButton),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                          ),
                          child: Text(
                            l10n.payOnDeliveryButton,
                            style: KTypography.k9(context, color: Colors.white)?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      
                      // Payer maintenant
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.handlePayment(context, l10n.payNowButton),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tertiary,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                            elevation: 0,
                          ),
                          child: Text(
                            l10n.payNowButton,
                            style: KTypography.k9(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      
                      // Envoyer la facture
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.handlePayment(context, l10n.sendInvoiceButton),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD3D3D3),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                            elevation: 0,
                          ),
                          child: Text(
                            l10n.sendInvoiceButton,
                            style: KTypography.k9(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
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