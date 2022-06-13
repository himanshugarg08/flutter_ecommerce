class Product {
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
    required this.options,
  });

  final String id;
  final String name;
  final String category;
  final String brand;
  final String description;
  final String price;
  final String rating;
  final List<String> images;
  final Options options;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        brand: json["brand"],
        description: json["description"],
        price: json["price"],
        rating: json["rating"],
        images: List<String>.from(json["images"].map((x) => x)),
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "brand": brand,
        "description": description,
        "price": price,
        "rating": rating,
        "images": List<dynamic>.from(images.map((x) => x)),
        "options": options.toJson(),
      };
}

class Options {
  Options({
    required this.colors,
    required this.varients,
  });

  final List<String> colors;
  final List<String> varients;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        colors: List<String>.from(json["colors"].map((x) => x)),
        varients: List<String>.from(json["varients"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "varients": List<dynamic>.from(varients.map((x) => x)),
      };
}
