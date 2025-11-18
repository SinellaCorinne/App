import 'package:flutter/material.dart';
import 'package:noworry_app/theme/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Exemple de CustomCategoryTabs avec traduction
class CustomCategoryTabs extends StatelessWidget {
  final TabController controller;
  final List<String> tabKeys; // Utiliser des clés ARB au lieu de textes fixes

  const CustomCategoryTabs({
    super.key,
    required this.controller,
    required this.tabKeys,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    // Map des clés ARB vers leur traduction
    String getTranslatedTitle(String key) {
      switch (key) {
        case 'tabStocks':
          return l.tabStocks;
        case 'tabOrders':
          return l.tabOrders;
        case 'tabBalance':
          return l.tabBalance;
        case 'tabProfile':
          return l.tabProfile;
        default:
          return key; // Fallback
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      color: Colors.transparent,
      child: TabBar(
        dividerColor: Colors.transparent,
        controller: controller,
        isScrollable: true,
        indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: Colors.transparent)),
        tabAlignment: TabAlignment.start,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        tabs: tabKeys.map((key) {
          final index = tabKeys.indexOf(key);
          final isSelected = controller.index == index;

          return Tab(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 1.2,
                ),
              ),
              child: Text(
                getTranslatedTitle(key),
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? AppColors.primary : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
