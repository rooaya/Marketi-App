// lib/models/favorite/add_favorite_response.dart
class AddFavoriteResponse {
  final String message;

  AddFavoriteResponse({required this.message});

  factory AddFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return AddFavoriteResponse(
      message: json['message'] ?? '',
    );
  }
}