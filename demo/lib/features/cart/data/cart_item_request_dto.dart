class CartItemRequestDto {
  final String name;
  final int shoeId;
  final double size;
  final int price;
  final int quantity;
  final String image;
  final String username;

  const CartItemRequestDto({
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
      'name': name,
      'shoe_id': shoeId,
      'size': size,
      'price': price,
      'quantity': quantity,
      'image': image,
      'username': username,
    };
  }
}