// product_state.dart
part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final ProductsResponse products;
  ProductSuccess(this.products);
}

final class ProductByIdSuccess extends ProductState {
  final Product product;
  ProductByIdSuccess(this.product);
}

final class ProductFailure extends ProductState {
  final Failure failure;
  ProductFailure(this.failure);
}