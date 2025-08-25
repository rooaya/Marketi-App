class CategoryNamesResponse {
  final List<CategoryItem> list;

  CategoryNamesResponse({required this.list});

  factory CategoryNamesResponse.fromJson(Map<String, dynamic> json) {
    return CategoryNamesResponse(
      list: (json['list'] as List<dynamic>)
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryItem {
  final String name;

  CategoryItem({required this.name});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}