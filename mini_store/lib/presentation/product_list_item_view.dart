import 'package:flutter/material.dart';
import 'package:mini_store/domain/product.dart';

class ProductListItemView extends StatelessWidget {
  const ProductListItemView({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: Hero(
              tag: product.id,
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                width: 90,
                height: 90,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
      
                  Text(
                    '\$ ${product.price}',
                    
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
