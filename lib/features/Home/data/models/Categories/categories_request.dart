// lib/models/category/categories_request.dart
class CategoriesRequest {
  final String token;

  CategoriesRequest({required this.token});

  Map<String, String> toHeaders() {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}