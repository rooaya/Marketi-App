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

class Category {
  final String slug;
  final String name;
  final String url;
  final String image;

  Category({
    required this.slug,
    required this.name,
    required this.url,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
      'image': image,
    };
  }
}
