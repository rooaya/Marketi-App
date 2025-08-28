// category_state.dart
part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final CategoriesResponse categories;
  CategorySuccess(this.categories);
}

final class CategoryFailure extends CategoryState {
  final Failure failure;
  CategoryFailure(this.failure);
}