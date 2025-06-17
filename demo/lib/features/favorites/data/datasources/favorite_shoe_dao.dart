import 'package:demo/features/favorites/data/datasources/app_database.dart';
import 'package:demo/features/favorites/data/models/favorite_shoe_dto.dart';

class FavoriteShoeDao {
  Future<void> insertFavorite(FavoriteShoeDto favorite) async {
    final database = await AppDatabase().database;
    await database.insert('favorites', favorite.toMap());
  }

  Future<void> deleteFavorite(int id) async {
    final database = await AppDatabase().database;
    await database.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FavoriteShoeDto>> fetchAll() async {
    final database = await AppDatabase().database;
    final maps = await database.query('favorites');

    return maps.map((e) => FavoriteShoeDto.fromMap(e)).toList();
  }

  Future<bool> isFavorite(int id) async {
    final database = await AppDatabase().database;
    final maps = await database.query('favorites', where: 'id = ?',whereArgs: [id]);
    return maps.isNotEmpty;
  }
}
