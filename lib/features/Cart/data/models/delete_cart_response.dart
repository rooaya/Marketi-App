// lib/models/cart/delete_cart_response.dart
class DeleteCartResponse {
  final String message;

  DeleteCartResponse({required this.message});

  factory DeleteCartResponse.fromJson(Map<String, dynamic> json) {
    return DeleteCartResponse(
      message: json['message'] ?? '',
    );
  }
}