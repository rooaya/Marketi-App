// lib/models/favorite/favorite_model.dart
class FavoriteItem {
  // Add your favorite item properties here
  final String id;
  final String name;

  FavoriteItem({
    required this.id,
    required this.name,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}