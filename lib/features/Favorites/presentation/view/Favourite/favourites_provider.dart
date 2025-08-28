// // favorites_provider.dart
// import 'package:flutter/material.dart';

// class FavoritesProvider with ChangeNotifier {
//   final List<Map<String, dynamic>> _favoriteItems = [];

//   List<Map<String, dynamic>> get favoriteItems => _favoriteItems;

//   void addToFavorites(Map<String, dynamic> product) {
//     if (!_favoriteItems.any((item) => item['id'] == product['id'])) {
//       _favoriteItems.add(product);
//       notifyListeners();
//     }
//   }

//   void removeFromFavorites(String productId) {
//     _favoriteItems.removeWhere((item) => item['id'] == productId);
//     notifyListeners();
//   }

//   bool isFavorite(String productId) {
//     return _favoriteItems.any((item) => item['id'] == productId);
//   }
// }