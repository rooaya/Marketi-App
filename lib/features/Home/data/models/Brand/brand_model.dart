class Brand {
  final String name;
  final String emoji;

  Brand({
    required this.name,
    required this.emoji,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['name'] ?? '',
      emoji: json['emoji'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'emoji': emoji,
    };
  }
}