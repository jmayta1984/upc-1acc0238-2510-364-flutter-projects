import 'package:demo/features/favorites/domain/entities/favorite_shoe.dart';

class FavoriteShoeDto {
  final int id;
  final String name;
  final String image;
  final int price;

  const FavoriteShoeDto({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  // Converts a FavoriteShoeDto to a FavoriteShoe domain entity.
  FavoriteShoe toDomain() {
    return FavoriteShoe(id: id, name: name, image: image, price: price);
  }

  // Converts a FavoriteShoe domain entity to a FavoriteShoeDto.
  factory FavoriteShoeDto.fromDomain(FavoriteShoe favoriteShoe) {
    return FavoriteShoeDto(
      id: favoriteShoe.id,
      name: favoriteShoe.name,
      image: favoriteShoe.image,
      price: favoriteShoe.price,
    );
  }

  // Converts a FavoriteShoeDto to a Map for storage.
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image': image, 'price': price};
  }

  // Converts a Map to a FavoriteShoeDto.
  factory FavoriteShoeDto.fromMap(Map<String, dynamic> map) {
    return FavoriteShoeDto(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
    );
  }
}
