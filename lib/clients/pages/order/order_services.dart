
import 'package:noworry_app/data/models/order.dart';

class OrderService {
  /// Simule l'appel API pour récupérer les commandes de l'utilisateur
  Future<List<Order>> fetchOrders() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simule le chargement
    
    // Données structurées qui proviendraient de l'API
    return [
      Order(
        id: 'O1',
        produit: 'Salade Originale',
        clientName: 'Jean Dupont',
        quantite: '2 unités',
        prixTotal: '4000 FCFA',
        adresse: '123 Rue de la Liberté, Cotonou',
        telephone: '66 12 34 56',
        statut: 'pending',
        category: 'client',
      ),
      Order(
        id: 'O2',
        produit: 'Boissons Gazeuses (Lot)',
        clientName: 'Grossiste Alpha',
        quantite: '10 cartons',
        prixTotal: '75000 FCFA',
        adresse: 'Zone Industrielle, Porto-Novo',
        telephone: '97 65 43 21',
        statut: 'confirmed',
        category: 'grossiste',
      ),
      Order(
        id: 'O3',
        produit: 'Salade Originale',
        clientName: 'Sophie Bernard',
        quantite: '1 unité',
        prixTotal: '2000 FCFA',
        adresse: 'Avenue de l\'Indépendance',
        telephone: '60 00 00 00',
        statut: 'delivered',
        category: 'client',
      ),
    ];
  }
}