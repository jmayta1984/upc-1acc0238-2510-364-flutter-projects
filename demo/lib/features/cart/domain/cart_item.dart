class CartItem {
  final int id;
  final String name;
  final int shoeId;
  final double size;
  final int price;
  final int quantity;
  final String image;
  final String username;

  const CartItem({
    required this.id,
    required this.name,
    required this.shoeId,
    required this.size,
    required this.price,
    required this.quantity,
    required this.image,
    required this.username,
  });
}
