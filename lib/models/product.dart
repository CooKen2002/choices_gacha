class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String rarity; 
  final String description;

  const Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rarity,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rarity: json['rarity'] ?? '',
      description: json['description'] ?? '',
    );
  }
}