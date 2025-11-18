// lib/widgets/product_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/clients/pages/product/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  final String productName;
  final String restaurantName;
  final String price;
  final String imageUrl;
  final int quantity;
  final VoidCallback onAddToCart;
  final ValueChanged<int> onQuantityChanged;
  final AppLocalizations l10n;

  const ProductItem({
    super.key,
    required this.productName,
    required this.restaurantName,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    required this.onAddToCart,
    required this.onQuantityChanged,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    
// Jaune bouton
// Fond compteur

   LinearGradient degrade = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD700), // Jaune doré
      Color(0x9CFF9F0D), // Orange avec 61% d’opacité (9C en alpha)
    ],
    stops: [0.0, 1.0],
  );

    return GestureDetector(
     // TEMPORAIRE POUR DÉBOGAGE
onTap: () {
  print("Tapped on product: $productName"); // Imprimer dans la console
  try {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(productId: 'original_salad'),
      ),
    );
  } catch (e) {
    print("Navigation Error: $e"); // Capturer une erreur de navigation
  }
}, 
            
              child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        
        decoration: const BoxDecoration(
           border: const Border(
    top: BorderSide(color: Color(0xFFD3D3D3), width: 0.5),
    left: BorderSide(color: Color(0xFFD3D3D3), width: 0.5),
    right: BorderSide(color: Color(0xFFD3D3D3), width: 0.5),
    bottom: BorderSide.none, // 👈 aucune bordure en bas
  ),
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(8.0),
    topRight: Radius.circular(8.0),
  ),
          color: Colors.transparent,
         
        
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Ligne principale : image + infos + prix/compteur
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image produit
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
              
                  // Détails produit
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          restaurantName,
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  // Prix et compteur
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$price F',
                        style: const  TextStyle(
                          fontFamily: "Source Sans Pro",
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => onQuantityChanged(quantity - 1),
                            child:  Container(
                              width: 28,
                              height: 28,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF858C94),
                        
                            ),
                            child: Icon(Icons.remove, size: 14, color: Colors.white),
                            alignment: Alignment.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontFamily: "Source Sans Pro",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => onQuantityChanged(quantity + 1),
                            child:  Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: degrade,
                      
                              ),
                              child:Icon(Icons.add, size: 14, color: Colors.white) ,
                              alignment: Alignment.center,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 10),
      
            // 🔹 Bouton “Ajouter au Panier”
            Container(
  width: double.infinity,
  // 1. Utiliser Material pour que l'InkWell puisse fonctionner correctement
  child: Material(
    color:Color(0xFFFFD700), // La couleur de fond désirée
    borderRadius: BorderRadius.circular(0), // Ajout de coins arrondis
    child: InkWell(
      onTap: onAddToCart, // 2. L'action cliquable
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        // 3. Le Container pour définir le padding et la hauteur
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center, // Centrer le texte
        child: Text(
          l10n.addToCartButton,
          style: const TextStyle(
            fontFamily: "Montserrat",
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}
