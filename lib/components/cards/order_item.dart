
import 'package:iconsax/iconsax.dart';

import '../../theme/styles.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String productName;
  final String restaurantName;
  final String price;
  final String statusText;
  final Color statusColor;
  final bool isDelivered;
  final String leaveReviewLinkText;
  final VoidCallback? onLeaveReviewTap;

  const OrderItem({
    super.key,
    required this.productName,
    required this.restaurantName,
    required this.price,
    required this.statusText,
    required this.statusColor,
    this.isDelivered = false,
    required this.leaveReviewLinkText,
    this.onLeaveReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          
          borderRadius:const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: AppColors.grayL,
          style: BorderStyle.solid,
          width: 0.5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                             color: Colors.black87,
                          ),
                        ),
                        Text(
                          restaurantName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Puce de Statut
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: isDelivered ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      // Lien d'Avis si c'est "Livrer"
                      if (isDelivered)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            onTap: onLeaveReviewTap,
                            child: Row(
                              children: [
                                 Icon(Iconsax.message1, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  leaveReviewLinkText, // 🔑 Traduction
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
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