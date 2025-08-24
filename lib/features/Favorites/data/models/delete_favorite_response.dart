// lib/models/favorite/delete_favorite_response.dart
class DeleteFavoriteResponse {
  final String message;

  DeleteFavoriteResponse({required this.message});

  factory DeleteFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFavoriteResponse(
      message: json['message'] ?? '',
    );
  }
}