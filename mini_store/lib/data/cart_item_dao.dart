import 'package:mini_store/data/app_database.dart';
import 'package:mini_store/data/cart_item_dto.dart';
import 'package:mini_store/domain/cart_item.dart';
import 'package:mini_store/domain/product.dart';
import 'package:sqflite/sqflite.dart';

class CartItemDao {
  Future<void> addCartItem(Product product) async {
    Database database = await AppDatabase().database;
    List maps = await database.query(
      AppDatabase.tableName,
      where: 'id = ?',
      whereArgs: [product.id],
    );

    final CartItemDto cartItemDto = maps.isNotEmpty
        ? CartItemDto.fromDatabase(
            maps[0],
          ).copyWith(quantity: CartItemDto.fromDatabase(maps[0]).quantity + 1)
        : CartItemDto(
            id: product.id,
            title: product.title,
            price: product.price,
            image: product.image,
            quantity: 1,
          );

    await database.insert(
      AppDatabase.tableName,
      cartItemDto.toDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeCartItem(int id) async {
    Database database = await AppDatabase().database;
    await database.delete(
      AppDatabase.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<CartItem>> fetchAllCartItems() async {
    Database database = await AppDatabase().database;
    List maps = await database.query(AppDatabase.tableName);
    return maps.map((e) => CartItemDto.fromDatabase(e).toDomain()).toList();
  }
}
