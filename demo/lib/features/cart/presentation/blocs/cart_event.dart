abstract class CartEvent {
  const CartEvent();
}

class LoadCartEvent extends CartEvent {
  final String username;
  const LoadCartEvent({required this.username});
}

class AddToCartEvent extends CartEvent {
  final int shoeId;
  final String name;
  final int price;
  final double size;
  final int quantity;
  final String username;
  final String image;

  const AddToCartEvent({
    required this.shoeId,
    required this.name,
    required this.price,
    required this.size,
    required this.quantity,
    required this.username,
    required this.image,
  });
}

class RemoveFromCartEvent extends CartEvent {
  final int id;
  const RemoveFromCartEvent({required this.id});
}

class UpdateCartItemEvent extends CartEvent {}

class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
