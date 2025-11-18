
// --- Modèles de Données (pour la compilation) ---
class Product {
  final String id; final String name; final String description; final double stockQuantity; final String stockUnit; final String price; final String priceUnit; final bool isInStock; final String category;
  Product({required this.id, required this.name, required this.description, required this.stockQuantity, required this.stockUnit, required this.price, required this.priceUnit, required this.isInStock, required this.category});
}

class Transaction {
  final String title; final String amount; final String productName; final String referenceValue;
  Transaction({required this.title, required this.amount, required this.productName, required this.referenceValue});
}
