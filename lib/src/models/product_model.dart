class Product {
  Product({
    this.id,
    required this.description,
    required this.name,
    required this.price,
    required this.stock,
  });

  Product.fromJson(String? id, Map<String, Object?> json)
      : this(
          id: id,
          name: json['name']! as String,
          description: json['description']! as String,
          price: json['price']! as double,
          stock: json['stock']! as int,
        );

  final String? id;
  final String name;
  final String description;
  final double price;
  final int stock;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
    };
  }
}
