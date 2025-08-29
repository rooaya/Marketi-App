// lib/features/favorites/presentation/cubit/favorite_cubit.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Favorites/data/models/repo/fav_repo.dart';
import 'package:marketiapp/features/favorites/data/models/add_favorite_response.dart';
import 'package:marketiapp/features/favorites/data/models/delete_favorite_response.dart';
import 'package:marketiapp/features/favorites/data/models/favorite_response.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo favoriteRepo;

  FavoriteCubit({required this.favoriteRepo}) : super(FavoriteInitial());

  // Get favorites
  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final response = await favoriteRepo.getFavorites();
      emit(FavoriteSuccess(response));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  // Add to favorites
  Future<void> addToFavorite(String token, String productId) async {
    emit(FavoriteAddLoading());
    try {
      final response = await favoriteRepo.addToFavorite(token, productId);
      emit(FavoriteAddSuccess(response));
      // Refresh favorites after adding
      getFavorites();
    } catch (e) {
      emit(FavoriteAddFailure(e.toString()));
    }
  }

  // Remove from favorites
  Future<void> removeFromFavorite(String token, String productId) async {
    emit(FavoriteRemoveLoading());
    try {
      final response = await favoriteRepo.removeFromFavorite(token, productId);
      emit(FavoriteRemoveSuccess(response));
      // Refresh favorites after removal
      getFavorites();
    } catch (e) {
      emit(FavoriteRemoveFailure(e.toString()));
    }
  }
}
