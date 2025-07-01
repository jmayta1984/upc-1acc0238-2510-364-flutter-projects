import 'package:flutter/material.dart';
import 'package:mini_store/data/cart_item_dao.dart';
import 'package:mini_store/domain/cart_item.dart';
import 'package:mini_store/presentation/cart_list_item_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> _cartItems = [];

  Future<void> _loadData() async {
    List<CartItem> cartItems = await CartItemDao().fetchAllCartItems();
    setState(() {
      _cartItems = cartItems;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = _cartItems[index];
        return CartListItemView(
          cartItem: cartItem,
          onDelete: () {
            CartItemDao().removeCartItem(cartItem.id);
            _loadData();
          },
        );
      },
    );
  }
}
