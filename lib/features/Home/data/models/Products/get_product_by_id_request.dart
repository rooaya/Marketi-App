// lib/features/products/data/models/get_product_by_id_request.dart
class GetProductByIdRequest {
  final String id;

  GetProductByIdRequest({required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}