// lib/features/products/data/models/get_products_request.dart
class GetProductsRequest {
  final int skip;
  final int limit;
  final String? sortBy;
  final String? order;

  GetProductsRequest({
    this.skip = 0,
    this.limit = 10,
    this.sortBy,
    this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'skip': skip,
      'limit': limit,
      if (sortBy != null) 'sortBy': sortBy,
      if (order != null) 'order': order,
    };
  }
}