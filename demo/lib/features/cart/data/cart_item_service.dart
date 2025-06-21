import 'dart:convert';
import 'dart:io';

import 'package:demo/features/cart/data/cart_item_dto.dart';
import 'package:demo/features/cart/data/cart_item_request_dto.dart';
import 'package:http/http.dart' as http;

class CartItemService {
  

  Future<List<CartItemDto>> getCarItems(String username) async {
    final uri = Uri.parse("https://sugary-wool-penguin.glitch.me/cart_items?username=$username");
    http.Response response = await http.get(uri);
    if (response.statusCode == HttpStatus.ok) {
      final List maps = jsonDecode(response.body);
      return maps.map((e) => CartItemDto.fromJson(e)).toList();
    }
    return Future.error("Error fetching cart items: ${response.statusCode}");
  }

  Future<CartItemDto> addCartItem(CartItemRequestDto cartItem) async {
    final uri = Uri.parse("https://sugary-wool-penguin.glitch.me/cart_items");
    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cartItem.toJson()),
    );
    if (response.statusCode == HttpStatus.created) {
      return CartItemDto.fromJson(jsonDecode(response.body));
    }
    return Future.error("Error adding cart item: ${response.statusCode}");
  }
  Future<CartItemDto> updateCartItem(CartItemDto cartItem) async {
    final uri = Uri.parse("https://sugary-wool-penguin.glitch.me/cart_items/${cartItem.id}");
    http.Response response = await http.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cartItem.toJson()),
    );
    if (response.statusCode == HttpStatus.ok) {
      return CartItemDto.fromJson(jsonDecode(response.body));
    }
    return Future.error("Error updating cart item: ${response.statusCode}");
  }
  Future<void> removeCartItem(int id) async {
    final uri = Uri.parse("https://sugary-wool-penguin.glitch.me/cart_items/$id");
    http.Response response = await http.delete(uri);
    if (response.statusCode != HttpStatus.noContent) {
      return Future.error("Error removing cart item: ${response.statusCode}");
    }
  }
  Future<void> clearCart(String username) async {
    final uri = Uri.parse("https://sugary-wool-penguin.glitch.me/cart_items?username=$username");
    http.Response response = await http.delete(uri);
    if (response.statusCode != HttpStatus.noContent) {
      return Future.error("Error clearing cart: ${response.statusCode}");
    }
  }
 
}