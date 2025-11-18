// Fichier : lib/grossistes/pages/solde/solde_page.dart

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 💡 Import de Provider
import 'package:noworry_app/components/cards/solde.dart';
import 'package:noworry_app/theme/styles.dart';
import 'balance_controller.dart'; // 💡 Import du contrôleur

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Fournit et crée le contrôleur
    return ChangeNotifierProvider<BalanceController>(
      create: (_) => BalanceController(),
      child: const _BalanceView(),
    );
  }
}

class _BalanceView extends StatelessWidget {
  const _BalanceView();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    // 2. Écoute le contrôleur pour le solde et l'historique
    final controller = context.watch<BalanceController>();
    final transactionHistory = controller.transactionHistory;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- 1. Zone du SOLDE (Statique) ---
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                color: Colors.transparent,
                child: Column(
                  children: [
                    const Divider(height: 1, thickness: 1, color: AppColors.grayL),
                    const SizedBox(height: 10),
                    Text(
                      l.balance_label, // "SOLDE"
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade600,
                            letterSpacing: 1.5,
                          ),
                    ),
                    const SizedBox(height: 5),
                    // 💡 Utilise la valeur du contrôleur
                    Text(
                      controller.currentBalance, 
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 1, thickness: 1, color: AppColors.grayL),
                  ],
                ),
              ),

              // Titre Histoires
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  l.histories_title, // "HISTORIES"
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        letterSpacing: 1.0,
                      ),
                ),
              ),
            ]),
          ),

          // --- 2. Liste des Transactions (Dynamique) ---
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final transaction = transactionHistory[index];
                return TransactionHistoryCard(
                  title: transaction.title,
                  amount: transaction.amount,
                  productLabel: l.product_label, // "Produit"
                  productName: transaction.productName,
                  referenceLabel: l.reference_label, // "Référence"
                  referenceValue: transaction.referenceValue,
                );
              },
              // 💡 Utilise la longueur de la liste du contrôleur
              childCount: transactionHistory.length, 
            ),
          ),
        ],
      ),
    );
  }
}