// lib/features/favorites/data/repo/favorite_repo.dart
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/features/favorites/data/models/add_favorite_request.dart';
import 'package:marketiapp/features/favorites/data/models/add_favorite_response.dart';
import 'package:marketiapp/features/favorites/data/models/delete_favorite_request.dart';
import 'package:marketiapp/features/favorites/data/models/delete_favorite_response.dart';
import 'package:marketiapp/features/favorites/data/models/favorite_request.dart';
import 'package:marketiapp/features/favorites/data/models/favorite_response.dart';

class FavoriteRepo {
  final ApiConsumer api;

  FavoriteRepo({required this.api});

  // Get favorites
  Future<FavoriteResponse> getFavorites() async {
    try {
      final response = await api.get(EndPoints.getfav);
      return FavoriteResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }

  // Add to favorites
  Future<AddFavoriteResponse> addToFavorite(String token, String productId) async {
    try {
      final request = AddFavoriteRequest(token: token, productId: productId);
      final response = await api.post(
        EndPoints.addfav,
        data: request.toJson(),
      );
      return AddFavoriteResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }

  // Remove from favorites
  Future<DeleteFavoriteResponse> removeFromFavorite(String token, String productId) async {
    try {
      final request = DeleteFavoriteRequest(token: token, productId: productId);
      final response = await api.delete(
        EndPoints.delfav,
        data: request.toJson(),
      );
      return DeleteFavoriteResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to remove from favorites: $e');
    }
  }
}
