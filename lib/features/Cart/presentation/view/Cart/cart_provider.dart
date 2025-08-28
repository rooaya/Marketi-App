// // lib/features/Cart/presentation/view/Cart/cart_provider.dart
// import 'package:flutter/material.dart';

// class CartItem {
//   final String id;
//   final String name;
//   final String imageUrl;
//   final double price;
//   final double rating;
//   final String description;
//   final String size;
//   int quantity;

//   CartItem({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.price,
//     required this.rating,
//     required this.description,
//     required this.size,
//     this.quantity = 1,
//   });
// }

// class CartProvider with ChangeNotifier {
//   List<CartItem> _items = [];

//   List<CartItem> get items => _items;

//   void addItem(String id, String name, String imageUrl, double price, double rating, String description, String size, int quantity) {
//     final index = _items.indexWhere((item) => item.id == id && item.size == size);
//     if (index >= 0) {
//       _items[index].quantity += quantity;
//     } else {
//       _items.add(CartItem(
//         id: id,
//         name: name,
//         imageUrl: imageUrl,
//         price: price,
//         rating: rating,
//         description: description,
//         size: size,
//         quantity: quantity,
//       ));
//     }
//     notifyListeners();
//   }
// }