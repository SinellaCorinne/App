// Fichier : lib/pages/product_detail/product_detail_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/data/models/products_detail.dart';
// NOTE: Vous pourriez ajouter un ProductService pour simuler le fetch

class ProductDetailController extends ChangeNotifier {
  ProductDetailController({required String productId}) {
    // Dans une vraie application, on ferait un appel async ici
    _loadProductData(productId);
  }

  // --- État du produit ---
  ProductDetailModel? _product;
  ProductDetailModel? get product => _product;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // --- État de la Quantité (local à la page) ---
  int _currentQuantity = 1;
  int get currentQuantity => _currentQuantity;

  // --- Logique de Chargement et Mock ---

  void _loadProductData(String productId) {
    // Simule la récupération des données
    _product = ProductDetailModel(
      id: 'original_salad', 
      price: '2,000', 
      unit: 'F', 
      imageUrl: 'assets/images/plat.png', 
      categoryKey: 'FruitsVegetables', 
    );
    _isLoading = false;
    notifyListeners();
  }
  
  // --- Logique de la Quantité ---

  void incrementQuantity() {
    _currentQuantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_currentQuantity > 1) {
      _currentQuantity--;
      notifyListeners();
    }
  }

  // --- Logique de Localisation et Formatage ---

  String getLocalizedProductName(AppLocalizations l10n) {
    if (_product == null) return 'Loading...';
    switch (_product!.id) {
      case 'original_salad':
        return l10n.productOriginalSaladName; 
      default:
        return 'Product Not Found'; 
    }
  }

  String getLocalizedDescription(AppLocalizations l10n) {
    if (_product == null) return '';
    return l10n.productOriginalSaladDescription; 
  }

  String getLocalizedCategoryLabel(AppLocalizations l10n) {
    if (_product == null) return '';
    switch (_product!.categoryKey) {
      case 'FruitsVegetables':
        return l10n.categoryFruitsVegetables;
      default:
        return _product!.categoryKey; 
    }
  }

  String getLocalizedPrice(AppLocalizations l10n) {
    if (_product == null) return '';
    return '${_product!.price} ${_product!.unit}';
  }

  // --- Logique d'Action ---

  void addToCart(BuildContext context, AppLocalizations l10n) {
    if (_product == null) return;
    
    final productName = getLocalizedProductName(l10n);
    final quantity = _currentQuantity;
    
    // Logique d'ajout au panier (simulée)
    debugPrint('Ajout au panier: $quantity x $productName');
    
    // Affichage du SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.snackbarItemAdded(productName))),
    );
  }
}