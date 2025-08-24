// lib/features/cart/data/models/cart_request.dart
class CartRequest {
  Map<String, String> toHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}