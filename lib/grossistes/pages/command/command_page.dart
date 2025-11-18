
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:noworry_app/components/cards/card_commande.dart';

class Order {
  final String id;
  final String produit;
  final String clientName;
  final String quantite;
  final String prixTotal;
  final String adresse;
  final String telephone;
  final String statut;
  final String category;

  Order({
    required this.id,
    required this.produit,
    required this.clientName,
    required this.quantite,
    required this.prixTotal,
    required this.adresse,
    required this.telephone,
    required this.statut,
    required this.category,
  });
}

// --- Liste de commandes exemple ---
final List<Order> dummyOrders = [
  Order(
    id: 'o1',
    produit: "Sac de riz",
    clientName: "Oumar Sarr",
    quantite: "10C",
    prixTotal: "1200 F",
    adresse: "Rue du live, Dakar",
    telephone: "778909090",
    statut: "Pending",
    category: "FRUITS & LÉGUMES",
  ),
  Order(
    id: 'o2',
    produit: "Mangue Keitt",
    clientName: "Fatou Diop",
    quantite: "20kg",
    prixTotal: "5000 F",
    adresse: "Cité des jardins",
    telephone: "771234567",
    statut: "In preparation",
    category: "FRUITS & LÉGUMES",
  ),
  Order(
    id: 'o5',
    produit: "Eau de Javel",
    clientName: "Malick Ndiaye",
    quantite: "12L",
    prixTotal: "4800 F",
    adresse: "Yoff",
    telephone: "771122334",
    statut: "Pending",
    category: "HYGIÈNE & ENTRETIEN",
  ),
];

// --- Regroupement par catégorie ---
final Map<String, List<Order>> categorizedOrders = dummyOrders.fold({}, (map, order) {
  map.putIfAbsent(order.category, () => []).add(order);
  return map;
});

// --- OrdersListPage ---
class OrdersListPage extends StatelessWidget {
  const OrdersListPage({super.key});

  // Retourne la couleur du statut
  Color _getStatutColor(String statut) {
    switch (statut) {
      case "Pending":
        return Colors.orange;
      case "In preparation":
        return Colors.blue;
      case "In Shipping":
        return Colors.purple;
      case "Delivered":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Retourne le statut traduit via ARB
  String _getTranslatedStatut(String statut, AppLocalizations l) {
    switch (statut) {
      case "Pending":
        return l.statusPending;
      case "In preparation":
        return l.statusInPreparation;
      case "In Shipping":
        return l.statusInShipping;
      case "Delivered":
        return l.statusDelivered;
      default:
        return statut;
    }
  }

  // Retourne la catégorie traduite via ARB
  String _getTranslatedCategory(String category, AppLocalizations l) {
    switch (category) {
      case "FRUITS & LÉGUMES":
        return l.categoryFruitsLegumes;
      case "HYGIÈNE & ENTRETIEN":
        return l.categoryHygieneEntretien;
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final categories = categorizedOrders.keys.toList();

    return Scaffold(
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final orders = categorizedOrders[category]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre de la catégorie
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _getTranslatedCategory(category, l),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                ),
              ),
              // Liste des commandes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Column(
                  children: orders.map((order) {
                    return CommandeCard(
                      produit: order.produit,
                      clientName: order.clientName,
                      quantite: order.quantite,
                      prixTotal: order.prixTotal,
                      adresse: order.adresse,
                      telephone: order.telephone,
                      statut: _getTranslatedStatut(order.statut, l),
                      statutCouleur: _getStatutColor(order.statut),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
