// lib/features/favorites/presentation/cubit/favorite_cubit.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/favorites/data/models/favorite_model.dart';
import 'package:marketiapp/features/Favorites/data/models/repo/fav_repo.dart';
import 'package:marketiapp/features/favorites/data/models/add_favorite_response.dart';
import 'package:marketiapp/features/favorites/data/models/delete_favorite_response.dart';
import 'package:marketiapp/features/favorites/data/models/favorite_response.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo favoriteRepo;

  FavoriteCubit({required this.favoriteRepo}) : super(FavoriteInitial());

  List<FavoriteItem> fav = [];
  // Get favorites
  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final response = await favoriteRepo.getFavorites();
      fav = [...response.list];
      emit(FavoriteSuccess(response));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  // Add to favorites
  Future<void> addToFavorite(String productId) async {
    emit(FavoriteAddLoading(productId));
    try {
      final response = await favoriteRepo.addToFavorite(productId);
      getFavorites();
      emit(FavoriteAddSuccess(response));
      // Refresh favorites after adding
    } catch (e) {
      emit(FavoriteAddFailure(e.toString()));
    }
  }

  // Remove from favorites
  Future<void> removeFromFavorite(String productId) async {
    emit(FavoriteRemoveLoading(productId));
    try {
      final response = await favoriteRepo.removeFromFavorite(productId);
      getFavorites();
      emit(FavoriteRemoveSuccess(response));
      // Refresh favorites after removal
    } catch (e) {
      emit(FavoriteRemoveFailure(e.toString()));
    }
  }

  Future<void> toggleFavorite(String productId) async {
    final isFav = isProudinFav(productId);
    if (isFav) {
      await removeFromFavorite(productId);
    } else {
      await addToFavorite(productId);
    }
  }

  bool isProudinFav(String productid) {
    return fav.any((product) => product.id == productid);
  }
}
