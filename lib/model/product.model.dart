class Product {
  String id;
  String name;
  double price;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
