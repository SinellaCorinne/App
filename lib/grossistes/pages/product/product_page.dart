// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/components/cards/category_chip.dart';
import 'package:noworry_app/theme/styles.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, this.productId = "original_salad"});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController();
  int _currentQuantity = 1;

  void _incrementQuantity() {
    setState(() => _currentQuantity++);
  }

  void _decrementQuantity() {
    if (_currentQuantity > 1) {
      setState(() => _currentQuantity--);
    }
  }

  // --- Mock Data ---
  final Map<String, dynamic> _productData = {
    'id': 'original_salad',
    'price': '2,000',
    'unit': 'F',
    'image1': 'assets/images/plat.png',
    'image2': 'assets/images/plat.png',
    'image3': 'assets/images/plat.png',
    'categoryKey': 'FruitsVegetables',
  };

  // --- Localization Helpers ---
  String _getLocalizedDescription(AppLocalizations l10n) {
    return l10n.productOriginalSaladDescription;
  }

  String _getLocalizedCategoryLabel(AppLocalizations l10n, String categoryKey) {
    switch (categoryKey) {
      case 'FruitsVegetables':
        return l10n.categoryFruitsVegetables;
      default:
        return categoryKey;
    }
  }

  String _getLocalizedProductName(AppLocalizations l10n, String productId) {
    switch (productId) {
      case 'original_salad':
        return l10n.productOriginalSaladName;
      default:
        return 'Product Not Found';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final localizedProductName =
        _getLocalizedProductName(l10n, _productData['id']);
    final localizedPrice = '${_productData['price']} ${_productData['unit']}';
    final localizedCategory =
        _getLocalizedCategoryLabel(l10n, _productData['categoryKey']);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ---------------- SliverAppBar avec Carousel ----------------
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black, size: 16),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: PageView(
                  controller: _pageController,
                  children: [
                    Image.asset(_productData['image1'], fit: BoxFit.cover),
                    Image.asset(_productData['image2'], fit: BoxFit.cover),
                    Image.asset(_productData['image3'], fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
          ),

          // ---------------- Contenu Principal ----------------
          SliverToBoxAdapter(
            child: Container(
              transform: Matrix4.translationValues(0, -20, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    // Nom du produit + Prix
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizedProductName,
                          style: KTypography.h4(context,
                                  color: Colors.black)
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          localizedPrice,
                          style: KTypography.h4(context,
                                  color: Colors.black)
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _getLocalizedDescription(l10n),
                      style: KTypography.k9(context, color: Colors.black),
                    ),

                    const SizedBox(height: 16),

                    CategoryChip(
                      label: localizedCategory,
                      isSelected: true,
                      onTap: () {},
                    ),

                    const SizedBox(height: 24),

                    Text(
                      l10n.productReviewsTitle,
                      style: KTypography.k9(context, color: Colors.black)
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),

                    const SizedBox(height: 25),

                    _buildReviewItem(l10n),
                    _buildReviewItem(l10n),
                    _buildReviewItem(l10n),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------- Avis / Review Widget ----------
  Widget _buildReviewItem(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profil.jpg'),
            backgroundColor: Colors.grey,
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rosemary',
                  style: TextStyle(fontSize: 10, fontFamily: "Montserrat"),
                ),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < 4 ? Icons.star : Icons.star_border,
                      color: AppColors.tertiary,
                      size: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.productReviewMockText,
                  style: KTypography.k9(context, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
