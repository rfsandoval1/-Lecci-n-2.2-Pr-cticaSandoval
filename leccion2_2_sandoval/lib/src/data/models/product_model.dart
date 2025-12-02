import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required double rating,
    required int ratingCount,
  }) : super(
          id: id,
          title: title,
          price: price,
          description: description,
          category: category,
          image: image,
          rating: rating,
          ratingCount: ratingCount,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rating = (json['rating'] ?? {}) as Map<String, dynamic>;
    double rate = 0.0;
    int count = 0;
    if (rating.isNotEmpty) {
      rate = (rating['rate'] is int) ? (rating['rate'] as int).toDouble() : (rating['rate'] ?? 0).toDouble();
      count = (rating['count'] ?? 0) as int;
    }

    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] ?? 0).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: rate,
      ratingCount: count,
    );
  }
}
