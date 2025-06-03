class Category {
  final int? id;
  final String name;

  Category({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
