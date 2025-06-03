import 'package:demo/domain/shoe.dart';

class ShoeDto {
  final int id;
  final String name;
  final String image;
  final int price;
  final String brand;
  final String category;
  final List<ShoeSizeDto> sizes;
 
  ShoeDto({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
    required this.category,
    required this.sizes,
  });

  factory ShoeDto.fromJson(Map<String, dynamic> json) {
    return ShoeDto(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      brand: json['brand'],
      category: json['category'],
      sizes: (json['sizes'] as List)
          .map((size) => ShoeSizeDto(
                size: (size['size'] as num).toDouble(),
                quantity: size['quantity'] as int,
              ))
          .toList(),
    );
  }

  Shoe toDomain() {
    return Shoe(
      id: id,
      name: name,
      brand: brand,
      price: price,
      image: image,
    );
  }
}

class ShoeSizeDto {
  double size;
  int quantity;

  ShoeSizeDto({
    required this.size,
    required this.quantity,
  });
}