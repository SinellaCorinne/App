import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:noworry_app/clients/pages/home/home_controller.dart';
import 'package:noworry_app/clients/pages/home/page/home_page.dart';
import 'package:noworry_app/clients/pages/profil/profile_page.dart';
import 'package:noworry_app/clients/pages/order/order_page.dart';      
import 'package:noworry_app/theme/styles.dart'; 

class Home extends ConsumerWidget { 
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    final currentIndex = ref.watch(HomeControllerProvider);

    final controller = ref.read(HomeControllerProvider.notifier);
    
    // Définition des pages à afficher
    const List<Widget> pages = [
      HomePageContent(), // 0. Accueil
      OrdersPage(),   // 1. Favoris
      ProfilePage(),     // 2. Profil
    ];

    // Définition des éléments de la barre de navigation
    const List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(label:"", icon: Icon(Iconsax.home_2), ),
      BottomNavigationBarItem(label:"", icon: Icon(Iconsax.heart) ),
      BottomNavigationBarItem(label:"", icon: Icon(Iconsax.user)),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
     bottomNavigationBar: Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        offset: const Offset(0, -3),
        blurRadius: 8,
      ),
    ],
  ),
  child: BottomNavigationBar(
  
    currentIndex: currentIndex,
    onTap: controller.updateCurrentIndex,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.tertiary,
    unselectedItemColor: AppColors.grayD,
    backgroundColor: Colors.white,
     selectedFontSize: 12,
    unselectedFontSize: 12,
    items: items,
  ),
),

    );
  }
}

