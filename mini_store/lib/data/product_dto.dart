/*

{
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "rating": {
      "rate": 3.9,
      "count": 120
    }
}
*/

import 'package:mini_store/domain/product.dart';

class ProductDto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingProductDto rating;

  const ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: RatingProductDto.fromJson(json['rating'] as Map<String, dynamic>),
    );
  }

  Product toDomain() {
    return Product(
      id: id,
      title: title,
      price: price,
      image: image,
      category: category,
      rating: rating.rate,
      description: description
    );
  } 
}

class RatingProductDto {
  final double rate;
  final int count;

  const RatingProductDto({
    required this.rate,
    required this.count,
  });


  factory RatingProductDto.fromJson(Map<String, dynamic> json) {
    return RatingProductDto(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );
  }
}