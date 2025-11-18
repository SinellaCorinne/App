class HomeService {
  Future<List<String>> getCategories() async {
    return ["Tous", "Fruits & Légumes", "Hygiène & Entretien", "Boissons"];
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    return [
      {
        "name": "Original Salad",
        "restaurant": "Lovy Food",
        "price": 560,
        "image": "assets/images/image.jpg",
        "quantity": 1,
      },
      {
        "name": "Natural Juice",
        "restaurant": "Fresh Bar",
        "price": 1200,
        "image": "assets/images/image.jpg",
        "quantity": 1,
      },
      {
        "name": "Coca Cola",
        "restaurant": "Market24",
        "price": 500,
        "image": "assets/images/image.jpg",
        "quantity": 1,
      },
    ];
  }
}

//Integration de API
/**
 import 'package:dio/dio.dart';

class HomeService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://ton-backend.com/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // ------------------------------------------------
  // 🔹 Récupération des catégories
  // ------------------------------------------------
  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get('/categories');
      final data = response.data['data'];

      return List<String>.from(data.map((e) => e['name']));
    } catch (e) {
      // fallback local
      return [
        "Tous",
        "Fruits & Légumes",
        "Hygiène & Entretien",
        "Boissons",
      ];
    }
  }

  // ------------------------------------------------
  // 🔹 Récupération des produits
  // ------------------------------------------------
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      final data = response.data['data'];

      return List<Map<String, dynamic>>.from(data.map((e) => {
            "name": e["name"],
            "restaurant": e["restaurant"],
            "price": e["price"],
            "image": e["image"],
            "quantity": 1,
          }));
    } catch (e) {
      // fallback local
      return [
        {
          "name": "Original Salad",
          "restaurant": "Lovy Food",
          "price": 560,
          "image": "assets/images/image.jpg",
          "quantity": 1,
        },
        {
          "name": "Natural Juice",
          "restaurant": "Fresh Bar",
          "price": 1200,
          "image": "assets/images/image.jpg",
          "quantity": 1,
        },
        {
          "name": "Coca Cola",
          "restaurant": "Market24",
          "price": 500,
          "image": "assets/images/image.jpg",
          "quantity": 1,
        },
      ];
    }
  }
}

 */