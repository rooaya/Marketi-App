// lib/features/home/presentation/cubit/home_state.dart
part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final CategoriesResponse categories;
  final BrandsResponse brands;
  final CategoryNamesResponse categoryNames;
  final ProductsResponse products;

  HomeSuccess({
    required this.categories,
    required this.brands,
    required this.categoryNames,
    required this.products,
  });
}

final class HomeFailure extends HomeState {
  final Failure failure;
  HomeFailure(this.failure);
}

// Products specific states
final class HomeProductsLoading extends HomeState {}

final class HomeProductsSuccess extends HomeState {
  final ProductsResponse products;
  HomeProductsSuccess(this.products);
}

final class HomeProductsFailure extends HomeState {
  final Failure failure;
  HomeProductsFailure(this.failure);
}

// Single product states
final class HomeProductLoading extends HomeState {}

final class HomeProductSuccess extends HomeState {
  final Product product;
  HomeProductSuccess(this.product);
}

final class HomeProductFailure extends HomeState {
  final Failure failure;
  HomeProductFailure(this.failure);
}

// Categories specific states
final class HomeCategoriesLoading extends HomeState {}

final class HomeCategoriesSuccess extends HomeState {
  final CategoriesResponse categories;
  HomeCategoriesSuccess(this.categories);
}

final class HomeCategoriesFailure extends HomeState {
  final Failure failure;
  HomeCategoriesFailure(this.failure);
}

// Brands specific states
final class HomeBrandsLoading extends HomeState {}

final class HomeBrandsSuccess extends HomeState {
  final BrandsResponse brands;
  HomeBrandsSuccess(this.brands);
}

final class HomeBrandsFailure extends HomeState {
  final Failure failure;
  HomeBrandsFailure(this.failure);
}

// Category names specific states
final class HomeCategoryNamesLoading extends HomeState {}

final class HomeCategoryNamesSuccess extends HomeState {
  final CategoryNamesResponse categoryNames;
  HomeCategoryNamesSuccess(this.categoryNames);
}

final class HomeCategoryNamesFailure extends HomeState {
  final Failure failure;
  HomeCategoryNamesFailure(this.failure);
}