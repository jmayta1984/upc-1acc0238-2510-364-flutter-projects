import 'package:demo/features/home/domain/entities/shoe.dart';

class ShoeDto {
  final int id;
  final String name;
  final String gender;
  final String image;
  final int price;
  final String brand;
  final String category;
  final List<ShoeSizeDto> sizes;

  ShoeDto({
    required this.id,
    required this.name,
    required this.gender,
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
      gender: json['gender'],
      image: json['image'],
      price: json['price'],
      brand: json['brand'],
      category: json['category'],
      sizes: (json['sizes_available'] as List)
          .map(
            (size) => ShoeSizeDto(
              size: (size['size'] as num).toDouble(),
              quantity: size['quantity'] as int,
            ),
          )
          .toList(),
    );
  }

  Shoe toDomain() {
    return Shoe(
      id: id,
      name: name,
      brand: brand,
      gender: gender,
      price: price,
      image: image,
      sizes: sizes.map((e) => e.toDomain()).toList(),
    );
  }
}

class ShoeSizeDto {
  double size;
  int quantity;

  ShoeSizeDto({required this.size, required this.quantity});

  ShoeSize toDomain() {
    return ShoeSize(size: size, stock: quantity);
  }
}
