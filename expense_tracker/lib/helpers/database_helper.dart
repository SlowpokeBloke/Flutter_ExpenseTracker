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
  String colBudget = 'budget'; // Added budget column

  DatabaseHelper._createInstance();

  factory DatabaseHelper() => _databaseHelper;

  Future<Database> get database async {
    _db ??= await initializeDatabase();
    return _db!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'categories.db';
    return await openDatabase(path, version: 2, // Incremented version for schema change
      onCreate: _createDb,
      onUpgrade: _upgradeDb, // Handle upgrades
    );
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $categoriesTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName TEXT,
        $colBudget INTEGER DEFAULT 0) // Initialize budget column
    ''');
  }

  // Handle database upgrades
  void _upgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Assuming version 2 adds the budget column
      await db.execute('ALTER TABLE $categoriesTable ADD COLUMN $colBudget INTEGER DEFAULT 0');
    }
    // Implement further version checks and updates as needed
  }

  Future<int> insertCategory(Map<String, dynamic> categoryMap) async {
    Database db = await this.database;
    return await db.insert(categoriesTable, categoryMap);
  }

  Future<int> deleteCategory(int id) async {
    Database db = await this.database;
    return await db.delete(categoriesTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> updateCategoryBudget(int categoryId, int budget) async {
    Database db = await this.database;
    return await db.update(categoriesTable, {colBudget: budget}, where: '$colId = ?', whereArgs: [categoryId]);
  }

  Future<List<Map<String, dynamic>>> getCategoryMapList() async {
    Database db = await this.database;
    return await db.query(categoriesTable);
  }
}
