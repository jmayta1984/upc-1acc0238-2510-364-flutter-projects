import 'package:demo/features/cart/domain/cart_item.dart';

class CartItemDto {
  final int id;
  final String name;
  final int shoeId;
  final double size;
  final int price;
  final int quantity;
  final String image;
  final String username;

  const CartItemDto({
    required this.id,
    required this.name,
    required this.shoeId,
    required this.size,
    required this.price,
    required this.quantity,
    required this.image,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shoe_id': shoeId,
      'size': size,
      'price': price,
      'quantity': quantity,
      'image': image,
      'username': username,
    };
  }

  factory CartItemDto.fromJson(Map<String, dynamic> json) {
    return CartItemDto(
      id: json['id'],
      name: json['name'],
      shoeId: json['shoe_id'],
      size: (json['size'] as num).toDouble(),
      price: json['price'],
      quantity: json['quantity'],
      image: json['image'],
      username: json['username'],
    );
  }

  CartItem toDomain() {
    return CartItem(
      id: id,
      name: name,
      shoeId: shoeId,
      size: size,
      price: price,
      quantity: quantity,
      image: image,
      username: username,
    );
  }
}
