// Fichier : lib/components/cards/cart_item.dart

import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';

class CartItem extends StatelessWidget { 
  final String productName;
  final String restaurantName;
  final String price;
  final String imageUrl;
  final int quantity; // 💡 Reçoit la quantité du Controller
  final ValueChanged<int> onQuantityChanged; // 💡 Callback vers le Controller

  const CartItem({
    super.key,
    required this.productName,
    required this.restaurantName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.onQuantityChanged,
  });

  // La logique de dégradé reste ici car elle est purement visuelle
  LinearGradient get degrade => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF9646), // Jaune doré
      Color(0xFFFF9F0D), // Orange
    ],
    stops: [0.0, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD3D3D3),
              style: BorderStyle.solid,
              width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- 1. Image du Produit ---
              Container(
                width: 70, 
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.orange[600],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => 
                        const Center(child: Icon(Icons.error, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // --- 2. Information du Produit ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productName,
                      style: KTypography.h5(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      restaurantName,
                      style: KTypography.h7(context, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: KTypography.h5(context, color: AppColors.orangeP)?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              // --- 3. Sélecteur de Quantité ---
               Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Bouton Décrémenter
                        GestureDetector(
                          // Appelle le callback avec la nouvelle quantité (décrémentée)
                          onTap: () => onQuantityChanged(quantity - 1), 
                          child:  Container(
                            width: 28,
                            height: 28,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFF858C94),
                          ),
                          child: const Icon(Icons.remove, size: 14, color: Colors.white),
                          alignment: Alignment.center,
                          ),
                        ),
                        // Affichage de la Quantité
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
                        // Bouton Incrémenter
                        GestureDetector(
                          // Appelle le callback avec la nouvelle quantité (incrémentée)
                          onTap: () => onQuantityChanged(quantity + 1), 
                          child:  Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: degrade,
                            ),
                            child:const Icon(Icons.add, size: 14, color: Colors.white) ,
                            alignment: Alignment.center,
                            )
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}































































































































/**import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';


class ProductCartItem extends StatefulWidget {
  final String productName;
  final String restaurantName;
  final String price;
  final String imageUrl;

  const ProductCartItem({
    super.key,
    required this.productName,
    required this.restaurantName,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  int _currentQuantity = 1;

  void _incrementQuantity() {
    setState(() {
      _currentQuantity++;
    });
  }

  void _decrementQuantity() {
    if (_currentQuantity > 0) {
      setState(() {
        _currentQuantity--;
      });
    }
  }
   LinearGradient degrade = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF9646), // Jaune doré
      Color(0xFFFF9F0D), // Orange avec 61% d’opacité (9C en alpha)
    ],
    stops: [0.0, 1.0],
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        // Retirer l'ombre de la Card si elle est trop forte
         decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD3D3D3),
                    style: BorderStyle.solid,
                    width: 0.5,),
                      borderRadius:  const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.transparent,
       
       
      ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- 1. Image du Produit ---
              Container(
                width: 70, // Taille de l'image
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Coins arrondis de l'image
                  color: Colors.orange[600], // Couleur de fond de l'image (orange comme dans l'image)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    widget.imageUrl, // Votre asset
                    fit: BoxFit.cover,
                    // Placeholder ou image de secours (ici, l'image est un plat dans un cercle blanc)
                    errorBuilder: (context, error, stackTrace) => 
                        const Center(child: Icon(Icons.error, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // --- 2. Information du Produit (Nom, Restaurant, Prix) ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Nom du produit (Gras, Grande Taille)
                    Text(
                      widget.productName,
                      style: KTypography.h5(context, color: Colors.black)?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    // Nom du Restaurant (Gris clair)
                    Text(
                      widget.restaurantName,
                      style: KTypography.h7(context, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    // Prix (Orange, Gras)
                    Text(
                      widget.price,
                      style: KTypography.h5(context, color: AppColors.orangeP)?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              // --- 3. Sélecteur de Quantité ---
               Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _decrementQuantity(),
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
                            '$_currentQuantity',
                            style: const TextStyle(
                              fontFamily: "Source Sans Pro",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _incrementQuantity(),
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
        ),
      ),
    );
  }

 
}*/
