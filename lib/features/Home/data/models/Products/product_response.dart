// lib/features/products/data/models/products_response.dart
import 'product_model.dart';

class ProductsResponse {
  final List<Product> list;
  final int total;
  final int skip;
  final int limit;

  ProductsResponse({
    required this.list,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((item) => Product.fromJson(item))
          .toList() ??
          [],
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((item) => item.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}