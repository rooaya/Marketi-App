// lib/models/cart/cart_model.dart
class CartItem {
  // Add your cart item properties here based on API response
  final String id;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}