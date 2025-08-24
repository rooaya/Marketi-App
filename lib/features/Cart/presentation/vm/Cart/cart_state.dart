// lib/features/cart/presentation/cubit/cart_state.dart
part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartResponse cartResponse;
  CartSuccess(this.cartResponse);
}

final class CartFailure extends CartState {
  final String error;
  CartFailure(this.error);
}

final class CartAddLoading extends CartState {}

final class CartAddSuccess extends CartState {
  final AddCartResponse addCartResponse;
  CartAddSuccess(this.addCartResponse);
}

final class CartAddFailure extends CartState {
  final String error;
  CartAddFailure(this.error);
}

final class CartRemoveLoading extends CartState {}

final class CartRemoveSuccess extends CartState {
  final DeleteCartResponse deleteCartResponse;
  CartRemoveSuccess(this.deleteCartResponse);
}

final class CartRemoveFailure extends CartState {
  final String error;
  CartRemoveFailure(this.error);
}

final class CartUpdateLoading extends CartState {}

final class CartUpdateSuccess extends CartState {
  final AddCartResponse updateCartResponse;
  CartUpdateSuccess(this.updateCartResponse);
}

final class CartUpdateFailure extends CartState {
  final String error;
  CartUpdateFailure(this.error);
}