class Product {
  final int? id;
  final String name;
  final double price;

  Product({this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: (json['price'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {'name': name, 'price': price};
}
