

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();
  static Database? _db;

  String categoriesTable = 'categories_table';
  String colId = 'id';
  String colName = 'name';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() => _databaseHelper;

  Future<Database> get database async {
    _db ??= await initializeDatabase();
    return _db!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'categories.db';
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $categoriesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT)');
  }

  Future<int> insertCategory(Map<String, dynamic> categoryMap) async {
    Database db = await this.database;
    return await db.insert(categoriesTable, categoryMap);
  }

  Future<List<Map<String, dynamic>>> getCategoryMapList() async {
    Database db = await this.database;
    return await db.query(categoriesTable);
  }
}
