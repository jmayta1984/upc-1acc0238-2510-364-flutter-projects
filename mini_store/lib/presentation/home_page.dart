import 'package:flutter/material.dart';
import 'package:mini_store/data/product_service.dart';
import 'package:mini_store/domain/product.dart';
import 'package:mini_store/presentation/product_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];

  Future<void> _loadData() async {
    final products = await ProductService().getAllProducts();
    if (mounted) {
      setState(() {
        _products = products;
      });
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: ProductListView(products: _products))],
    );
  }
}
