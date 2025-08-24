// lib/features/cart/data/models/add_cart_request.dart
class AddCartRequest {
  final String productId;
  final int quantity;

  AddCartRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  Map<String, String> toHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}