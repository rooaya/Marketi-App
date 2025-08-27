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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Brand &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}