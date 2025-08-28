// products_by_category_state.dart
part of 'products_by_category_cubit.dart';

@immutable
sealed class ProductsByCategoryState {}

final class ProductsByCategoryInitial extends ProductsByCategoryState {}

final class ProductsByCategoryLoading extends ProductsByCategoryState {}

final class ProductsByCategorySuccess extends ProductsByCategoryState {
  final ProductsResponse products;
  ProductsByCategorySuccess(this.products);
}

final class ProductsByCategoryFailure extends ProductsByCategoryState {
  final Failure failure;
  ProductsByCategoryFailure(this.failure);
}