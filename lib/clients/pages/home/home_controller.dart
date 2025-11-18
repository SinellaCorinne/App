import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🧠 Ce provider gère l'index courant (équivalent de LogeController)
// ignore: non_constant_identifier_names
final HomeControllerProvider = StateNotifierProvider<HomeController, int>((ref) {
  return HomeController();
});

class HomeController extends StateNotifier<int> {
  HomeController() : super(0); // Valeur initiale (index 0)

  void updateCurrentIndex(int newIndex) {
    state = newIndex; // ⚡ Met à jour l’état
  }
}
