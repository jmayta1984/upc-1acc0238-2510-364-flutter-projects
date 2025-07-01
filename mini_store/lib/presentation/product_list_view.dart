import 'package:flutter/material.dart';
import 'package:mini_store/domain/product.dart';
import 'package:mini_store/presentation/product_detail_page.dart';
import 'package:mini_store/presentation/product_list_item_view.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },

          child: ProductListItemView(product: product),
        );
      },
    );
  }
}
