// lib/features/products/data/models/get_products_by_category_request.dart
class GetProductsByCategoryRequest {
  final String category;
  final int skip;
  final int limit;

  GetProductsByCategoryRequest({
    required this.category,
    this.skip = 0,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'skip': skip,
      'limit': limit,
    };
  }
}