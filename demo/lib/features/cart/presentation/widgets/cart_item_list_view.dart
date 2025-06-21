
import 'package:demo/features/cart/domain/cart_item.dart';
import 'package:flutter/material.dart';

class CartItemListView extends StatelessWidget {
  const CartItemListView({super.key, required this.items});
  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Image.network(item.image),
          title: Text(item.name),
          subtitle: Text('Size: ${item.size}, Price: \$${item.price}'),
          trailing: Text('Quantity: ${item.quantity}'),
        );
      },
    );
  }
}