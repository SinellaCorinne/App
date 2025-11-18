// Aucune dépendance à Flutter ici
class CartItemModel {
  final String id;
  final String restaurant;
  final int priceValue;
  final String imageUrl;
  int quantity; // La quantité est mutable dans le panier

  CartItemModel({
    required this.id,
    required this.restaurant,
    required this.priceValue,
    required this.imageUrl,
    required this.quantity,
  });
}