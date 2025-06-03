class DetailProduct {
  final int? id;
  final String name;
  final int cateogryId;
  final int stock;
  final String group;
  final int price;
  final String categoryName;

  DetailProduct({
    this.id,
    required this.name,
    required this.cateogryId,
    required this.stock,
    required this.group,
    required this.price,
    required this.categoryName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'category': cateogryId,
      'stock': stock,
      'product_group': group,
      'price': price,
      'category_name': categoryName,
    };
  }

  factory DetailProduct.fromJson(Map<String, dynamic> json) {
    return DetailProduct(
      id: json['id'],
      name: json['name'],
      cateogryId: json['category_id'],
      stock: json['stock'],
      group: json['product_group'],
      price: json['price'],
      categoryName: json['category_name']
    );
  }
}
