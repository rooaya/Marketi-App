import 'package:marketiapp/features/Home/data/models/Products/product_model.dart';

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
    var listJson = json['list'] as List;
    List<Product> products = listJson.map((e) => Product.fromJson(e)).toList();

    return ProductsResponse(
      list: products,
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((e) => e.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}