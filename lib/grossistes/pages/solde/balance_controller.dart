// Fichier : lib/grossistes/pages/solde/balance_controller.dart

import 'package:flutter/material.dart';
import '../../../../data/models/transaction_model.dart';

class BalanceController extends ChangeNotifier {
  // --- Données Mockées (État du Solde) ---
  final String _currentBalance = '125,000 F';
  String get currentBalance => _currentBalance;

  // --- Historique des Transactions Mockées ---
  final List<TransactionModel> _transactionHistory = [
    TransactionModel(
        title: 'Encaissement',
        amount: '+ 34,680 F',
        productName: 'Salade fruite',
        referenceValue: 'QWt90FGH0p334'),
    TransactionModel(
        title: 'Encaissement',
        amount: '+ 34,680 F',
        productName: 'Salade fruite',
        referenceValue: 'QWt90FGH0p334'),
    TransactionModel(
        title: 'Encaissement',
        amount: '+ 34,680 F',
        productName: 'Salade fruite',
        referenceValue: 'QWt90FGH0p334'),
    TransactionModel(
        title: 'Encaissement',
        amount: '+ 34,680 F',
        productName: 'Tomate cerise',
        referenceValue: 'REF123456789'),
    TransactionModel(
        title: 'Encaissement',
        amount: '+ 15,000 F',
        productName: 'Sac de riz',
        referenceValue: 'QAZWSXEDC'),
  ];
  List<TransactionModel> get transactionHistory => _transactionHistory;
  
  // Dans une application réelle, des méthodes pour fetch/mettre à jour l'historique
  // et le solde iraient ici, avec des appels à notifyListeners().
}