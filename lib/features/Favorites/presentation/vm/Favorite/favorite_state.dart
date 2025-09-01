// lib/features/favorites/presentation/cubit/favorite_state.dart
part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final FavoriteResponse favoriteResponse;
  FavoriteSuccess(this.favoriteResponse);
}

final class FavoriteFailure extends FavoriteState {
  final String error;
  FavoriteFailure(this.error);
}

final class FavoriteAddLoading extends FavoriteState {
  final String productId;
  FavoriteAddLoading(this.productId);
}

final class FavoriteAddSuccess extends FavoriteState {
  final AddFavoriteResponse addFavoriteResponse;
  FavoriteAddSuccess(this.addFavoriteResponse);
}

final class FavoriteAddFailure extends FavoriteState {
  final String error;
  FavoriteAddFailure(this.error);
}

final class FavoriteRemoveLoading extends FavoriteState {
  final String ProductId;
  FavoriteRemoveLoading(this.ProductId);
}

final class FavoriteRemoveSuccess extends FavoriteState {
  final DeleteFavoriteResponse deleteFavoriteResponse;
  FavoriteRemoveSuccess(this.deleteFavoriteResponse);
}

final class FavoriteRemoveFailure extends FavoriteState {
  final String error;
  FavoriteRemoveFailure(this.error);
}
