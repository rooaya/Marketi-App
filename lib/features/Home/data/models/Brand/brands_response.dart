import 'brand_model.dart';

class BrandsResponse {
  final List<Brand> list;
  final String message;

  BrandsResponse({
    required this.list,
    this.message = '',
  });

  factory BrandsResponse.fromJson(Map<String, dynamic> json) {
    return BrandsResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((item) => Brand.fromJson(item))
          .toList() ??
          [],
      message: json['message'] ?? '',
    );
  }
}