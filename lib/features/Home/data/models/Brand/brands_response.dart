import 'brand_model.dart';

class BrandsResponse {
  final List<Brand> list;

  BrandsResponse({required this.list});

  factory BrandsResponse.fromJson(Map<String, dynamic> json) {
    var listJson = json['list'] as List;
    List<Brand> brands = listJson.map((e) => Brand.fromJson(e)).toList();

    return BrandsResponse(list: brands);
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((e) => e.toJson()).toList(),
    };
  }
}