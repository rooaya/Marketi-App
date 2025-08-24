// lib/features/cart/data/models/add_cart_response.dart
class AddCartResponse {
  final String message;
  final bool status;

  AddCartResponse({required this.message, required this.status});

  factory AddCartResponse.fromJson(Map<String, dynamic> json) {
    return AddCartResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }
}