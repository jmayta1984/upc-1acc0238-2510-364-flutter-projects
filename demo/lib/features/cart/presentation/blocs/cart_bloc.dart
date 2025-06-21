import 'package:demo/features/cart/data/cart_item_repository.dart';
import 'package:demo/features/cart/presentation/blocs/cart_event.dart';
import 'package:demo/features/cart/presentation/blocs/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartItemRepository _cartItemRepository = CartItemRepository();
  CartBloc() : super(InitialCartState()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<ClearCartEvent>(_onClearCart);
  }

  void _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingCartState());
    try {
      final items = await _cartItemRepository.getCartItems(event.username);
      emit(SuccessCartState(items: items));
    } catch (e) {
      emit(FailureCartState(errorMessage: e.toString()));
    }
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingCartState());
    await _cartItemRepository.addCartItem(
      shoeId: event.shoeId,
      name: event.name,
      price: event.price,
      size: event.size,
      quantity: event.quantity,
      username: event.username,
      image: event.image,
    );
    try {
      emit(
        SuccessCartState(
          items: await _cartItemRepository.getCartItems(event.username),
        ),
      );
    } catch (e) {
      emit(FailureCartState(errorMessage: e.toString()));
    }
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    // Logic to remove item from cart
  }

  void _onUpdateCartItem(UpdateCartItemEvent event, Emitter<CartState> emit) {
    // Logic to update cart item
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    // Logic to clear the cart
  }
}
