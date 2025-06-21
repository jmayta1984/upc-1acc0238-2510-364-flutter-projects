import 'package:demo/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:demo/features/auth/presentation/blocs/auth_state.dart';
import 'package:demo/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:demo/features/cart/presentation/blocs/cart_event.dart';
import 'package:demo/features/cart/presentation/blocs/cart_state.dart';
import 'package:demo/features/cart/presentation/widgets/cart_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    if (context.read<AuthBloc>().state is SuccessAuthState) {
      final user = (context.read<AuthBloc>().state as SuccessAuthState).user;
      context.read<CartBloc>().add(LoadCartEvent(username: user.username));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to view your cart')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is SuccessCartState) {
            if (state.items.isEmpty) {
              return Center(child: Text('No items in the cart'));
            }
            return CartItemListView(items: state.items);
          }
          return Center();
        },
      ),
    );
  }
}
