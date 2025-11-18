class HomeLogic {
  String selectedCategory = "Tous";

  void selectCategory(String category) {
    selectedCategory = category;
  }

  void updateQuantity(List products, int index, int q) {
    if (q >= 1) {
      products[index]["quantity"] = q;
    }
  }
}

//Integration de l'API
/**
 class HomeLogic {
  String selectedCategory = "Tous";

  void selectCategory(String category) {
    selectedCategory = category;
  }

  void updateQuantity(List products, int index, int q) {
    if (q >= 1) {
      products[index]['quantity'] = q;
    }
  }
}

 */