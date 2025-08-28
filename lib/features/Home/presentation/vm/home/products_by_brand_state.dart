// products_by_brand_state.dart
part of 'products_by_brand_cubit.dart';

@immutable
sealed class ProductsByBrandState {}

final class ProductsByBrandInitial extends ProductsByBrandState {}

final class ProductsByBrandLoading extends ProductsByBrandState {}

final class ProductsByBrandSuccess extends ProductsByBrandState {
  final ProductsResponse products;
  ProductsByBrandSuccess(this.products);
}

final class ProductsByBrandFailure extends ProductsByBrandState {
  final Failure failure;
  ProductsByBrandFailure(this.failure);
}