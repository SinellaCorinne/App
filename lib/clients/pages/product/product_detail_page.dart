// Fichier : lib/pages/product_detail/product_detail_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/components/cards/category_chip.dart';
import 'package:noworry_app/theme/styles.dart';
import 'product_detail_controller.dart'; 

class ProductDetailPage extends StatelessWidget {
  final String productId; 

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // Fournit le contrôleur avec l'ID du produit
    return ChangeNotifierProvider<ProductDetailController>(
      create: (_) => ProductDetailController(productId: productId),
      child: const _ProductDetailView(),
    );
  }
}

class _ProductDetailView extends StatelessWidget {
  const _ProductDetailView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Écoute le contrôleur pour l'état du produit et la quantité
    final controller = context.watch<ProductDetailController>();

    if (controller.isLoading || controller.product == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    // Obtenir les valeurs localisées
    final localizedProductName = controller.getLocalizedProductName(l10n);
    final localizedPrice = controller.getLocalizedPrice(l10n);
    final localizedCategory = controller.getLocalizedCategoryLabel(l10n);
    final productData = controller.product!; // Données disponibles

    return Scaffold(
      
      bottomNavigationBar: _buildFixedBottomBar(
        context, // Passé pour read
        l10n, 
        controller, // Passé pour la quantité
      ),
      
      body: CustomScrollView(
        slivers: <Widget>[
          // --- 1. Image en haut de page (Sliver AppBar) ---
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: Colors.transparent, 
            leading: _buildBackButton(context), // Widget pour le bouton Retour
            flexibleSpace: FlexibleSpaceBar(
  background: Padding(
    padding: const EdgeInsets.all(0.5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: _buildImageSlider(),
    ),
  ),
),

          ),
          
          // --- 2. Contenu de la page (Sliver List/ToBoxAdapter) ---
          SliverToBoxAdapter(
            child: Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0), 
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), 
                  topRight: Radius.circular(20.0), 
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Nom du produit et Prix
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizedProductName, 
                          style: KTypography.h4(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          localizedPrice, 
                          style: KTypography.h4(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      controller.getLocalizedDescription(l10n), 
                      style: KTypography.k9(context, color: Colors.black),
                    ),
                    const SizedBox(height: 16),

                    // Puce de Catégorie 
                    CategoryChip(
                      label: localizedCategory, 
                      isSelected: true,
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),

                    // Titre "Les Avis"
                    Text(
                      l10n.productReviewsTitle, 
                      style: KTypography.k9(context, color: Colors.black)?.copyWith(decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 25),

                    // Liste des Avis (réutilisation du widget)
                    _buildReviewItem(context, l10n),
                    _buildReviewItem(context, l10n),
                    _buildReviewItem(context, l10n),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBackButton(BuildContext context) {
      return Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.all(13.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
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
      );
  }

  // Widget pour un seul Avis
  Widget _buildReviewItem(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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
                // Étoiles de notation
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_border, 
                      color: AppColors.tertiary,
                      size: 8,
                    );
                  }),
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

  // Widget pour la Barre d'Action fixe en bas
  Widget _buildFixedBottomBar(
    BuildContext context, 
    AppLocalizations l10n, 
    ProductDetailController controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), 
      decoration:  BoxDecoration(
        color: Colors.transparent,
        border: const Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1.0)),
        boxShadow:[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -3),
            blurRadius: 8,
          ),
        ] 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton "Ajouter au Panier"
         SizedBox(
            width: 150, 
            child: ElevatedButton(
              // 💡 Appelle l'action du contrôleur
              onPressed: () => controller.addToCart(context, l10n),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 31),
                backgroundColor: AppColors.tertiary,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.addToCartButton,
                textAlign: TextAlign.center,
                style: KTypography.k9(context, color: Colors.black)
              ),
            ),
          ), 
          
          // Sélecteur de Quantité
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Bouton Décrémenter
              GestureDetector(
                // 💡 Appelle la méthode du contrôleur
                onTap: controller.decrementQuantity,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.grayL,
                  ),
                  child: const Icon(Icons.remove, size: 14, color: Colors.white),
                  alignment: Alignment.center,
                ),
              ),
              // Affichage de la Quantité
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  // 💡 Utilise l'état du contrôleur
                  '${controller.currentQuantity}',
                  style: const TextStyle(
                    fontFamily: "Source Sans Pro",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              // Bouton Incrémenter
              GestureDetector(
                // 💡 Appelle la méthode du contrôleur
                onTap: controller.incrementQuantity,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.tertiary,
                  ),
                  child: const Icon(Icons.add, size: 14, color: Colors.white),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
  final List<String> images = [
    "assets/images/plat.png",
    "assets/images/plat.png",
    "assets/images/plat.png",
    "assets/images/plat.png",
  ];

  return StatefulBuilder(
    builder: (context, setState) {
      int currentIndex = 0;

      return Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemBuilder: (_, index) {
              return Image.asset(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.error, size: 80)),
              );
            },
          ),

          // --- Petits indicateurs de pages (Dots) ---
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (dotIndex) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == dotIndex ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == dotIndex
                        ? Colors.white
                        : Colors.white54,
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
              }),
            ),
          ),
        ],
      );
    },
  );
}

}