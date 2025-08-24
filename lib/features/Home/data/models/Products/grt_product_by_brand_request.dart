// lib/features/products/data/models/get_products_by_brand_request.dart
class GetProductsByBrandRequest {
  final String brand;
  final int skip;
  final int limit;

  GetProductsByBrandRequest({
    required this.brand,
    this.skip = 0,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'skip': skip,
      'limit': limit,
    };
  }
}