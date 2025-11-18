// --- 2. MODÈLE DE DONNÉES ET DONNÉES DE DÉMO ---

class Order {
  final String id;
  final String produit;
  final String clientName;
  final String quantite;
  final String prixTotal;
  final String adresse;
  final String telephone;
  final String statut;
  final String category; // Pour le regroupement

  Order({
    required this.id, required this.produit, required this.clientName, 
    required this.quantite, required this.prixTotal, required this.adresse, 
    required this.telephone, required this.statut, required this.category,
  });
}