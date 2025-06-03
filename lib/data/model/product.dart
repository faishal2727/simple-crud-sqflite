class Product {
  final int? id;
  final String name;
  final int cateogryId;
  final int stock;
  final String group;
  final int price;

  Product({
    this.id,
    required this.name,
    required this.cateogryId,
    required this.stock,
    required this.group,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'category': cateogryId,
      'stock': stock,
      'product_group': group,
      'price': price,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      cateogryId: json['category'],
      stock: json['stock'],
      group: json['product_group'],
      price: json['price'],
    );
  }
}
