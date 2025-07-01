import 'package:newsly/data/app_data.dart';
import 'package:newsly/data/favorite_news_dto.dart';
import 'package:newsly/domain/favorite_news.dart';
import 'package:newsly/domain/news.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteNewsDao {
  Future<void> addFavoriteNews(News news) async {
    Database database = await AppDatabase().database;

    await database.insert(
      'news',
      FavoriteNewsDto(
        author: news.author,
        description: news.description,
        image: news.image,
        title: news.title,
      ).toDatabase(),
    );
  }

  Future<void> removeFavoriteNews(String title) async {
    Database database = await AppDatabase().database;
    await database.delete('news', where: ' title = ?', whereArgs: [title]);
  }

  Future<List<FavoriteNews>> fetchAll() async {
    Database database = await AppDatabase().database;
    List maps = await database.query('news');
    return maps
        .map((map) => FavoriteNewsDto.fromDatabase(map).toDomain())
        .toList();
  }

  Future<bool> checkFavorite(String title) async {
    Database database = await AppDatabase().database;
    List maps = await database.query(
      'news',
      where: ' title = ?',
      whereArgs: [title],
    );
    return maps.isNotEmpty;
  }
}
