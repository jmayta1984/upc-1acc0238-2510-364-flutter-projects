import 'package:flutter/material.dart';
import 'package:mini_store/domain/cart_item.dart';

class CartListItemView extends StatelessWidget {
  const CartListItemView({
    super.key,
    required this.cartItem,
    required this.onDelete,
  });
  final CartItem cartItem;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Image.network(
            cartItem.image,
            fit: BoxFit.contain,
            width: 90,
            height: 90,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('\$ ${cartItem.price}'),
                  Text('Quantity: ${cartItem.quantity}'),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              onDelete();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
