import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noworry_app/clients/pages/order/order_controller.dart';
// NOTE: L'import de OrderItem est géré par le contrôleur dans la fonction buildOrderItems
// import 'package:noworry_app/components/cards/order_item.dart'; 
import 'package:noworry_app/theme/styles.dart'; 


class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Fournit et initialise le contrôleur avec l'objet de traduction
    return ChangeNotifierProvider<OrdersController>(
      // L'appel .loadInitialData(l10n) doit se faire ici pour avoir l'objet l10n
      create: (_) => OrdersController()..loadInitialData(l10n), 
      child: const _OrdersView(),
    );
  }
}

// UI Pure (StatelessWidget)
class _OrdersView extends StatelessWidget {
  const _OrdersView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Écoute les changements du contrôleur pour reconstruire la liste
    final controller = context.watch<OrdersController>();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent, 
        elevation: 0,  
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.ordersTitle,
          style: KTypography.h4(context, color: AppColors.primary)?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          // La liste est construite par le contrôleur
          children: controller.buildOrderItems(context, l10n),
        ),
      ),
    );
  }
}