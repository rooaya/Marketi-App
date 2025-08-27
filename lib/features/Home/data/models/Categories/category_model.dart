class Category {
  final String? slug;
  final String name;
  final String? url;
  final String? image;

  Category({
    this.slug,
    required this.name,
    this.url,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      slug: json['slug'],
      name: json['name'] ?? '',
      url: json['url'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (slug != null) 'slug': slug,
      'name': name,
      if (url != null) 'url': url,
      if (image != null) 'image': image,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          slug == other.slug &&
          name == other.name;

  @override
  int get hashCode => slug.hashCode ^ name.hashCode;
}