import 'package:mini_store/domain/cart_item.dart';

class CartItemDto {
  final int id;
  final String title;
  final double price;
  final String image;
  final int quantity;

  const CartItemDto({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartItemDto.fromDatabase(Map<String, dynamic> map) {
    return CartItemDto(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      image: map['image'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory CartItemDto.fromDomain(CartItem cartItem) {
    return CartItemDto(
      id: cartItem.id,
      title: cartItem.title,
      image: cartItem.image,
      quantity: cartItem.quantity,
      price: cartItem.price,
    );
  }

  CartItem toDomain() {
    return CartItem(
      id: id,
      title: title,
      price: price,
      image: image,
      quantity: quantity,
    );
  }

  CartItemDto copyWith({
    int? quantity,
    String? title,
    double? price,
    String? image,
  }) {
    return CartItemDto(
      id: id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}
