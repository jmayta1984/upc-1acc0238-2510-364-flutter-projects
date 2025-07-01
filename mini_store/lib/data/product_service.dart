import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mini_store/data/product_dto.dart';
import 'package:mini_store/domain/product.dart';

class ProductService {
  final uri = Uri.parse("https://sugary-wool-penguin.glitch.me/products");

  Future<List<Product>> getAllProducts() async {
    final http.Response response = await http.get(uri);

    try {
      if (response.statusCode == HttpStatus.ok) {
        final List maps = jsonDecode(response.body);
        return maps
            .map((json) => ProductDto.fromJson(json).toDomain())
            .toList();
      } else {
        return Future.error("${response.statusCode}");
      }
    } catch (e) {

      return Future.error(e.toString());
    }
  }
}
