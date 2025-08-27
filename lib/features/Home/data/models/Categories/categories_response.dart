import 'category_model.dart';

class CategoriesResponse {
  final List<Category> list;

  CategoriesResponse({required this.list});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    var listJson = json['list'] as List;
    List<Category> categories = listJson.map((e) => Category.fromJson(e)).toList();

    return CategoriesResponse(list: categories);
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((e) => e.toJson()).toList(),
    };
  }
}