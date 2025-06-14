import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AppDatabase {
  static final String dbName = 'easyshoes.db';
  static final int version = 1;

  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }
  AppDatabase._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db as Database;
    _db = await _initDb();
    return _db as Database;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: version, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE favorites(
          id INTEGER PRIMARY KEY,
          name TEXT, 
          image TEXT, 
          price INTEGER)''');
  }
}
