import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommandeCard extends StatelessWidget {
  final String produit;
  final String clientName;
  final String quantite;
  final String prixTotal;
  final String adresse;
  final String telephone;
  final String statut;
  final Color statutCouleur;

  const CommandeCard({
    super.key,
    required this.produit,
    required this.clientName,
    required this.quantite,
    required this.prixTotal,
    required this.adresse,
    required this.telephone,
    required this.statut,
    required this.statutCouleur,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    // Mapper les labels statiques en traductions
    Map<String, String> labels = {
      "Client": l.orderClient,
      "Quantité": l.orderQuantity,
      "Prix Total": l.orderTotalPrice,
      "Adresse": l.orderAddress,
      "Téléphone": l.orderPhone,
      "Statut": l.orderStatus,
    };

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- En-tête ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  produit,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  statut,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: statutCouleur,
                  ),
                ),
              ],
            ),
          ),

          // ---- Divider SANS padding ----
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.grey.shade300,
          ),

          // ---- Contenu ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              children: [
                buildInfoRow(labels[l.orderClient] ?? "Client", clientName),
                buildInfoRow(labels[l.orderQuantity] ?? "Quantité", quantite),
                buildInfoRow(labels[l.orderTotalPrice] ?? "Prix Total", prixTotal),
                buildInfoRow(labels[l.orderAddress] ?? "Adresse", adresse),
                buildInfoRow(labels[l.orderPhone] ?? "Téléphone", telephone),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.grey.shade600,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
