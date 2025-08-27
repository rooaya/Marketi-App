// lib/features/cart/presentation/cubit/cart_cubit.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Cart/data/models/add_cart_response.dart';
import 'package:marketiapp/features/Cart/data/models/cart_response.dart';
import 'package:marketiapp/features/Cart/data/models/delete_cart_response.dart';
import 'package:marketiapp/features/Cart/data/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit({required this.cartRepo}) : super(CartInitial());

  // Get cart items
  Future<void> getCart(String token) async {
    emit(CartLoading());
    try {
      final response = await cartRepo.getCart(token);
      emit(CartSuccess(response));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  // Add item to cart
  Future<void> addToCart(String token, String productId, int quantity) async {
    emit(CartAddLoading());
    try {
      final response = await cartRepo.addToCart(token, productId, quantity);
      emit(CartAddSuccess(response));
      // Refresh cart after adding item
      getCart(token);
    } catch (e) {
      emit(CartAddFailure(e.toString()));
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(String token, String productId) async {
    emit(CartRemoveLoading());
    try {
      final response = await cartRepo.removeFromCart(token, productId);
      emit(CartRemoveSuccess(response));
      // Refresh cart after removal
      getCart(token);
    } catch (e) {
      emit(CartRemoveFailure(e.toString()));
    }
  }

  // Update cart item quantity
  Future<void> updateCartQuantity(String token, String productId, int quantity) async {
    emit(CartUpdateLoading());
    try {
      final response = await cartRepo.updateCartQuantity(token, productId, quantity);
      emit(CartUpdateSuccess(response));
      // Refresh cart after updating quantity
      getCart(token);
    } catch (e) {
      emit(CartUpdateFailure(e.toString()));
    }
  }
}