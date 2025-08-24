// lib/features/cart/data/models/cart_response.dart
import 'package:marketiapp/features/Cart/data/models/cart_model.dart';


class CartResponse {
  final List<CartItem> items;
  final String message;
  final bool status;

  CartResponse({
    required this.items,
    this.message = '',
    required this.status,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: (json['data']?['items'] as List<dynamic>?)
          ?.map((item) => CartItem.fromJson(item))
          .toList() ??
          [],
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }
}