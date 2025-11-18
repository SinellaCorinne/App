
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:noworry_app/components/cards/category_tab.dart';
import 'package:noworry_app/components/cards/stock_card.dart';
import 'package:noworry_app/grossistes/pages/command/command_page.dart';
import 'package:noworry_app/grossistes/pages/profil/profil_page.dart';
import 'package:noworry_app/grossistes/pages/solde/solde_page.dart';
import 'package:noworry_app/grossistes/pages/stock/stock_page.dart';
import 'package:noworry_app/theme/styles.dart';

List<Product> dummyProducts(BuildContext context) {
  final l = AppLocalizations.of(context)!;

  return [
    Product(
      id: 'p1',
      name: l.productNameSample,
      description: l.productDescriptionSample,
      stockQuantity: 123,
      stockUnit: 'kg',
      price: '1200',
      priceUnit: 'F',
      isInStock: true,
      category: l.categoryFruitsLegumes,
    ),
    Product(
      id: 'p2',
      name: l.productNameSample,
      description: l.productDescriptionSample,
      stockQuantity: 123,
      stockUnit: 'kg',
      price: '1200',
      priceUnit: 'F',
      isInStock: false,
      category: l.categoryFruitsLegumes,
    ),
    Product(
      id: 'p3',
      name: l.productNameSample,
      description: l.productDescriptionSample,
      stockQuantity: 123,
      stockUnit: 'kg',
      price: '1200',
      priceUnit: 'F',
      isInStock: true,
      category: l.categoryHygieneEntretien,
    ),
  ];
}

// ----------------------
// DASHBOARD PAGE
// ----------------------

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late List<Map<String, dynamic>> _tabsConfig;
  late TabController _tabController;

  String _currentTitle = "";
  late List<Product> _products;

  @override
  void initState() {
    super.initState();
  }

  // reconstruit les onglets pour refléter la langue actuelle
  void _buildTabsConfig(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    _tabsConfig = [
      {
        'title': l.tabStocks,
        'route': '/stocks',
        'view': StocksView(
          products: _products,
          onToggleStock: _toggleStockStatus,
        )
      },
      {
        'title': l.tabOrders,
        'route': '/commandes',
        'view': OrdersListPage()
      },
      {
        'title': l.tabBalance,
        'route': '/solde',
        'view': BalancePage()
      },
      {
        'title': l.tabProfile,
        'route': '/profile',
        'view': ProfilPage()
      },
    ];

    _currentTitle = _tabsConfig[_tabController.index]['title'];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Charger les produits localisés
    _products = dummyProducts(context);

    // Initialise TabController
    _tabController = TabController(length: 4, vsync: this);

    _buildTabsConfig(context);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _currentTitle = _tabsConfig[_tabController.index]['title'];
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ----------------------
  // Toggle Stock
  // ----------------------
  void _toggleStockStatus(Product product, bool newValue) {
    setState(() {
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = Product(
          id: product.id,
          name: product.name,
          description: product.description,
          stockQuantity: product.stockQuantity,
          stockUnit: product.stockUnit,
          price: product.price,
          priceUnit: product.priceUnit,
          isInStock: newValue,
          category: product.category,
        );
      }

      _buildTabsConfig(context); // 🔄 met à jour la vue StocksView
    });
  }

  @override
  Widget build(BuildContext context) {
    _tabsConfig.map((e) => e['title'] as String).toList();
    final tabViews = _tabsConfig.map((e) => e['view'] as Widget).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        title: Text(
          _currentTitle,
          style: KTypography.h1(context)?.copyWith(fontSize: 16),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Divider(height: 1, thickness: 1, color: AppColors.grayL),

          // Tabs
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomCategoryTabs(
  controller: _tabController,
  tabKeys: ['tabStocks', 'tabOrders', 'tabBalance', 'tabProfile'],
)

              ),
            ],
          ),

          // Contenu
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabViews,
            ),
          ),
        ],
      ),
    );
  }
}