// Fichier : lib/pages/cart/cart_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/data/models/panier.dart';

class CartController extends ChangeNotifier {
  // --- Données Mockées (État du Panier) ---
  final List<CartItemModel> _cartItems = [
    CartItemModel(
        id: 'original_salad',
        restaurant: 'Lovy Food',
        priceValue: 2000,
        imageUrl: 'assets/images/image.jpg',
        quantity: 1),
    CartItemModel(
        id: 'original_salad',
        restaurant: 'Lovy Food',
        priceValue: 2000,
        imageUrl: 'assets/images/image.jpg',
        quantity: 1),
    CartItemModel(
        id: 'original_salad',
        restaurant: 'Lovy Food',
        priceValue: 2000,
        imageUrl: 'assets/images/image.jpg',
        quantity: 1),
  ];
  List<CartItemModel> get cartItems => _cartItems;

  // Coûts fixes pour les détails
  final int deliveryCost = 500;
  final int discount = 800;

  // --- Calculs (Getters) ---

  int get subtotal =>
      _cartItems.fold(0, (sum, item) => sum + (item.priceValue * item.quantity));

  int get total => subtotal + deliveryCost - discount;

  // --- Logique métier et Actions ---

  void updateQuantity(CartItemModel item, int newQuantity) {
    if (newQuantity >= 1) {
      item.quantity = newQuantity;
    } else if (newQuantity == 0) {
      // Supprimer l'article
      _cartItems.remove(item);
    }
    notifyListeners(); // Informe l'UI du changement
  }

  String getLocalizedProductName(AppLocalizations l10n, String productId) {
    switch (productId) {
      case 'original_salad':
        return l10n.productOriginalSaladName;
      default:
        return 'Original Salad';
    }
  }

  void handlePayment(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Action: $action')),
    );
  }
}