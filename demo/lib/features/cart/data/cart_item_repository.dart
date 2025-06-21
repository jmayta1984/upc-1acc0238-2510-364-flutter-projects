import 'package:demo/features/cart/data/cart_item_request_dto.dart';
import 'package:demo/features/cart/data/cart_item_service.dart';
import 'package:demo/features/cart/domain/cart_item.dart';

class CartItemRepository {
  final CartItemService _cartItemService = CartItemService();

  Future<List<CartItem>> getCartItems(String username) async {
    try {
      final cartItemsDto = await _cartItemService.getCarItems(username);
      return cartItemsDto.map((dto) => dto.toDomain()).toList();
    } catch (e) {
      return Future.error("Error fetching cart items: $e");
    }
  }

  Future<CartItem> addCartItem({
    required int shoeId,
    required String name,
    required int price,
    required double size,
    required int quantity,
    required String username,
    required String image,
  }) async {
    try {
      final cartItemDto = await _cartItemService.addCartItem(
        CartItemRequestDto(
          shoeId: shoeId,
          name: name,
          price: price,
          size: size,
          quantity: quantity,
          username: username,
          image: image,
        ),
      );
      return cartItemDto.toDomain();
    } catch (e) {
      return Future.error("Error adding cart item: $e");
    }
  }
}
