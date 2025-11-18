// Fichier : lib/data/models/transaction_model.dart

// -------------------------------------------------------------------
// MODELE DE DONNÉES
// -------------------------------------------------------------------
class TransactionModel {
  final String title;
  final String amount;
  final String productName;
  final String referenceValue;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.productName,
    required this.referenceValue,
  });
}