import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'home_logic.dart';
import 'home_service.dart';
import 'package:noworry_app/components/cards/category_chip.dart';
import 'package:noworry_app/components/cards/product_item.dart';
import 'package:noworry_app/clients/pages/panier/panier_page.dart';
import 'package:noworry_app/theme/styles.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final HomeLogic _logic = HomeLogic();
  final HomeService _service = HomeService();

  List<Map<String, dynamic>> _products = [];
  List<String> _categories = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final cats = await _service.getCategories();
    final prods = await _service.getProducts();

    setState(() {
      _categories = cats;
      _products = prods;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: _buildSearchBar(l10n),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBanner(l10n),
              const SizedBox(height: 10),
              _buildCategories(),
              const SizedBox(height: 16),
              _buildProducts(l10n),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------
  // 🔹 UI Elements
  // ------------------------------------------------

  Widget _buildSearchBar(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              hintText: l10n.searchDishesRestaurants,
              border: InputBorder.none,
              prefixIcon: const Icon(Iconsax.search_normal),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Iconsax.shopping_bag),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(AppLocalizations l10n) {
    return Container(
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/images/home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          l10n.onafaliBannerTitle,
          style: KTypography.h1(context, color: Colors.white)
              ?.copyWith(fontSize: 32),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (_, index) {
          final cat = _categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryChip(
              label: cat,
              isSelected: _logic.selectedCategory == cat,
              onTap: () =>
                  setState(() => _logic.selectCategory(cat)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProducts(AppLocalizations l10n) {
    return Column(
      children: List.generate(
        _products.length,
        (index) {
          final product = _products[index];

          return ProductItem(
            l10n: l10n,
            productName: product['name'],
            restaurantName: product['restaurant'],
            price: product['price'].toString(),
            imageUrl: product['image'],
            quantity: product['quantity'],
            onAddToCart: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product['name']} ajouté !")),
              );
            },
            onQuantityChanged: (q) {
              setState(() =>
                  _logic.updateQuantity(_products, index, q));
            },
          );
        },
      ),
    );
  }
}
