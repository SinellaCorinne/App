import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/theme/styles.dart'; 
import 'package:noworry_app/components/cards/order_item.dart';

// --- Modèle simple pour le contrôleur (simule le format d'API) ---
// Utilisation d'un Map pour coller exactement à la structure du code initial
class OrderData {
  final String productNameId; // Pour la localisation
  final String restaurantName;
  final String priceValue; // Juste la valeur, sans unité
  final String statusKey; // 'pending', 'in_preparation', etc.
  final bool isDelivered;

  OrderData({
    required this.productNameId,
    required this.restaurantName,
    required this.priceValue,
    required this.statusKey,
    required this.isDelivered,
  });
}
// --- Fin du Modèle ---


class OrdersController extends ChangeNotifier {
  List<OrderData> _rawOrders = [];
  bool _isLoading = true; 
  bool get isLoading => _isLoading;

  // L'initialisation doit être faite après que l'objet l10n est disponible (dans la page)
  void loadInitialData(AppLocalizations l10n) {
    _rawOrders = _getMockRawOrders();
    _isLoading = false;
    notifyListeners();
  }

  // --- 1. Simulation d'API (Données Brutes) ---
  List<OrderData> _getMockRawOrders() {
    // Dans une vraie application, cette fonction ferait l'appel à OrderService.fetchOrders()
    return [
      OrderData(
          productNameId: 'original_salad', restaurantName: 'Lovy Food', priceValue: '2000', statusKey: 'pending', isDelivered: false),
      OrderData(
          productNameId: 'original_salad', restaurantName: 'Lovy Food', priceValue: '2000', statusKey: 'in_preparation', isDelivered: false),
      OrderData(
          productNameId: 'original_salad', restaurantName: 'Lovy Food', priceValue: '2000', statusKey: 'in_shipping', isDelivered: false),
      OrderData(
          productNameId: 'original_salad', restaurantName: 'Lovy Food', priceValue: '2000', statusKey: 'delivered', isDelivered: true),
    ];
  }


  // --- 2. Logique de Préparation et de Traduction pour la Vue ---

  Color getStatusColor(String statusKey) {
    switch (statusKey) {
      case 'pending': return AppColors.grayL;
      case 'in_preparation': return AppColors.indigo;
      case 'in_shipping': return AppColors.tertiary;
      case 'delivered': return AppColors.primary;
      default: return Colors.black;
    }
  }

  String getLocalizedStatusText(AppLocalizations l10n, String statusKey) {
    // Utilise les clés du l10n pour la traduction
    switch (statusKey) {
      case 'pending': return l10n.statusPending;
      case 'in_preparation': return l10n.statusInPreparation;
      case 'in_shipping': return l10n.statusInShipping;
      case 'delivered': return l10n.statusDelivered;
      default: return statusKey;
    }
  }

  String getLocalizedProductName(AppLocalizations l10n, String id) {
    // Utilise les clés du l10n pour la traduction
    return l10n.productOriginalSaladName; // Simule la traduction
  }

  // Crée la liste de widgets OrderItem, en préparant toutes les données
  List<Widget> buildOrderItems(BuildContext context, AppLocalizations l10n) {
    if (_isLoading) {
      return [const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))];
    }
    
    return _rawOrders.map((order) {
      final price = '${order.priceValue} ${l10n.priceUnit}';
      final statusText = getLocalizedStatusText(l10n, order.statusKey);
      final statusColor = getStatusColor(order.statusKey);
      final productName = getLocalizedProductName(l10n, order.productNameId);

      return OrderItem(
        productName: productName,
        restaurantName: order.restaurantName,
        price: price,
        statusText: statusText,
        statusColor: statusColor,
        isDelivered: order.isDelivered,
        leaveReviewLinkText: l10n.leaveReviewLink,
        // Appel de la logique du contrôleur si c'est livré
        onLeaveReviewTap: order.isDelivered ? handleLeaveReview : null,
      );
    }).toList();
  }

  // --- 3. Logique d'Action ---
  void handleLeaveReview() {
    debugPrint('Navigation vers la page d\'avis (géré par le contrôleur)...');
  }
}