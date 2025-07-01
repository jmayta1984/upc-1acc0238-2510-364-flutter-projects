import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database as Database;
  }

  Future<Database> _initDb() async {
    final String path = join(await getDatabasesPath(), 'newsly.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table news (
            title text primary key,
            author text,
            image text,
            description text)
          ''');
      },
    );
  }
}
