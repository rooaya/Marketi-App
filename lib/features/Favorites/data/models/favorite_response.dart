// lib/models/favorite/favorite_response.dart
import 'favorite_model.dart';

class FavoriteResponse {
  final List<FavoriteItem> list;
  final String message;

  FavoriteResponse({
    required this.list,
    this.message = '',
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((item) => FavoriteItem.fromJson(item))
          .toList() ??
          [],
      message: json['message'] ?? '',
    );
  }
}