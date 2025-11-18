

class ProductDetailModel {
  final String id;
  final String price; // Prix non formaté (ex: '2,000')
  final String unit;  // Unité (ex: 'F')
  final String imageUrl;
  final String categoryKey;

  ProductDetailModel({
    required this.id,
    required this.price,
    required this.unit,
    required this.imageUrl,
    required this.categoryKey,
  });
}