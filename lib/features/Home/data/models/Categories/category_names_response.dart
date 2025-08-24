import 'category_model.dart';

class CategoryNamesResponse {
  final List<Category> list;
  final String message;

  CategoryNamesResponse({
    required this.list,
    this.message = '',
  });

  factory CategoryNamesResponse.fromJson(Map<String, dynamic> json) {
    return CategoryNamesResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((item) => Category.fromJson(item))
          .toList() ??
          [],
      message: json['message'] ?? '',
    );
  }
}