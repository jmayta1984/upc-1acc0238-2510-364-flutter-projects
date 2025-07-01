import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final _instance = AppDatabase._internal();
  static const String databaseName = 'app_database.db';
  static const String tableName = "items";

  static const int databaseVersion = 1;

  Database? _database;

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal();

  Future<Database> get database async {
    _database ??= await openDb();
    return _database as Database;
  }

  Future<Database> openDb() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: (db, version) {
        db.execute('''
        create table $tableName 
        (id integer primary key,
         title text, 
         image text, 
         price real, 
         quantity integer)
        ''');
      },
    );
  }
}
