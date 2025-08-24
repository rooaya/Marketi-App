// lib/features/cart/data/repo/cart_repo.dart
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/features/Cart/data/models/add_cart_request.dart';
import 'package:marketiapp/features/Cart/data/models/add_cart_response.dart';
import 'package:marketiapp/features/Cart/data/models/cart_request.dart';
import 'package:marketiapp/features/Cart/data/models/cart_response.dart';
import 'package:marketiapp/features/Cart/data/models/delete_cart_request.dart';
import 'package:marketiapp/features/Cart/data/models/delete_cart_response.dart';

class CartRepo {
  final ApiConsumer api;

  CartRepo({required this.api});

  // Get cart items
  Future<CartResponse> getCart(String token) async {
    try {
      final request = CartRequest();
      final response = await api.get(EndPoints.getcart);
      return CartResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  // Add item to cart
  Future<AddCartResponse> addToCart(
    String token,
    String productId,
    int quantity,
  ) async {
    try {
      final request = AddCartRequest(productId: productId, quantity: quantity);
      final response = await api.post(
        EndPoints.addcart,
        data: request.toJson(),
      );
      return AddCartResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  // Remove item from cart
  Future<DeleteCartResponse> removeFromCart(
    String token,
    String productId,
  ) async {
    try {
      final request = DeleteCartRequest(productId: productId);
      final response = await api.delete(
        EndPoints.delcart,
        data: request.toJson(),
      );
      return DeleteCartResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  // Update cart item quantity
  Future<AddCartResponse> updateCartQuantity(
    String token,
    String productId,
    int quantity,
  ) async {
    try {
      final request = AddCartRequest(productId: productId, quantity: quantity);
      final response = await api.get(
        EndPoints.addcart,
        data: request.toJson(),
      );
      return AddCartResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update cart quantity: $e');
    }
  }
}
