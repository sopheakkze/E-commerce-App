class Products {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final int quantity;
  // final Rating rating;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.quantity = 1,
    // required this.rating,
  });





  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] ?? 0,
      title: json['title'] ?? "No Title",
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? "No description available",
      category: json['category'] ?? "Uncategorized",
      image: json['image'] ??
          (json['images'] != null && json['images'].isNotEmpty
              ? json['images'][0]
              : "https://via.placeholder.com/150"),
      // rating: json['rating'] != null
      //     ? Rating.fromJson(json['rating'])
      //     : Rating(rate: 0.0, count: 0),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }
}

