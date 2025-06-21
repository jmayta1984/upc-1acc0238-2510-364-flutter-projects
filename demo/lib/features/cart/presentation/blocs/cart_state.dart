import 'package:demo/features/cart/domain/cart_item.dart';

abstract class CartState {
  const CartState();
}

class InitialCartState extends CartState {}

class LoadingCartState extends CartState {}

class SuccessCartState extends CartState {
  final List<CartItem> items;
  const SuccessCartState({required this.items});
}

class FailureCartState extends CartState {
  final String errorMessage;
  const FailureCartState({required this.errorMessage});
}
