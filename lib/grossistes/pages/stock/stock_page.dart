
import 'package:flutter/material.dart';
import 'package:noworry_app/components/cards/stock_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/grossistes/pages/add_product/add_product_page.dart';

Map<String, List<Product>> categorizeProducts(List<Product> products) {
  final Map<String, List<Product>> map = {};
  for (var product in products) {
    map.putIfAbsent(product.category, () => []).add(product);
  }
  return map;
}

class StocksView extends StatelessWidget {
  final List<Product> products;
  final Function(Product, bool) onToggleStock;

  const StocksView({
    super.key,
    required this.products,
    required this.onToggleStock,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final categorizedProducts = categorizeProducts(products);
    final categories = categorizedProducts.keys.toList();

    return Scaffold(
      // ---------------- BODY ----------------
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final prods = categorizedProducts[category]!;

          // 🔥 Vous pouvez remplacer cette logique quand l’API retournera les vrais totaux
          final totalCount =
              prods.length + (category.contains('FRUITS') ? 11 : 17);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- TITRE CATÉGORIE ----
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category, // catégorie déjà traduite dans Product
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                    ),
                    Text(
                      '$totalCount',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
              ),

              // ---- GRID DES PRODUITS ----
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: prods.length,
                itemBuilder: (context, productIndex) {
                  final product = prods[productIndex];
                  return ProductOverviewCard(
                    product: product,
                    onToggleStock: (v) => onToggleStock(product, v),
                    onEdit: () {},
                  );
                },
              ),
            ],
          );
        },
      ),

      // ---------------- FLOATING BUTTON ----------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AddProductPage(),
            ),
          );
        },
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF006400),
              width: 15,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(6),
          child: const Icon(
            Icons.add,
            color: Color(0xFF006400),
            size: 15,
          ),
        ),
      ),
    );
  }
}
