// lib/features/cart/data/models/delete_cart_request.dart
class DeleteCartRequest {
  final String productId;

  DeleteCartRequest({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
    };
  }

  Map<String, String> toHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}