import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();
  static Database? _db;

  String categoriesTable = 'categories_table';
  String expensesTable = 'expenses_table'; // Define the expenses table name
  String colId = 'id';
  String colName = 'name';
  String colBudget = 'budget'; // Column for budget in categories

  // Columns for expenses table
  String colAmount = 'amount';
  String colCategoryId = 'categoryId';
  String colDescription = 'description';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() => _databaseHelper;

  Future<Database> get database async {
    _db ??= await initializeDatabase();
    return _db!;
  }


  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'finance.db'; 
    return await openDatabase(path, version: 2, onCreate: _createDb, onUpgrade: _upgradeDb);
  }

  void _createDb(Database db, int newVersion) async {
    // Create categories table
    await db.execute('''
      CREATE TABLE $categoriesTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName TEXT,
        $colBudget INTEGER DEFAULT 0)
    ''');

    // Create expenses table
    await db.execute('''
      CREATE TABLE $expensesTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colAmount INTEGER,
        $colCategoryId INTEGER,
        $colDescription TEXT,
        $colDate TEXT,
        FOREIGN KEY ($colCategoryId) REFERENCES $categoriesTable($colId))
    ''');
  }

  // Handle database upgrades
  void _upgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Assuming version 2 requires adding the expenses table
      await db.execute('''
        CREATE TABLE $expensesTable (
          $colId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colAmount INTEGER,
          $colCategoryId INTEGER,
          $colDescription TEXT,
          $colDate TEXT,
          FOREIGN KEY ($colCategoryId) REFERENCES $categoriesTable($colId))
      ''');
    }
    // Add more version checks and updates as needed
  }

  Future<int> insertCategory(String name, int initialBudget) async {
    Database db = await this.database;
    Map<String, dynamic> category = {
      'name': name,
      'budget': initialBudget,
    };
    return await db.insert(categoriesTable, category);
  }

  Future<int> deleteCategory(int id) async {
    Database db = await database;
    return await db.delete(categoriesTable, where: '$colId = ?', whereArgs: [id]);
  }


  Future<int> insertExpense(Map<String, dynamic> expenseMap) async {
    Database db = await this.database;
    return await db.insert(expensesTable, expenseMap);
  }

  Future<int> updateCategoryBudget(int categoryId, int budget) async {
    Database db = await database;
    return await db.update(categoriesTable, {colBudget: budget}, where: '$colId = ?', whereArgs: [categoryId]);
  }

  Future<List<Map<String, dynamic>>> getCategoryMapList() async {
    Database db = await database;
    return await db.query(categoriesTable);
  }

  // Method to fetch expenses joined with categories
  Future<List<Map<String, dynamic>>> getExpenses() async {
    final db = await this.database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT e.amount, e.description, e.date, c.name AS categoryName
      FROM expenses e
      JOIN categories c ON e.categoryId = c.id
      ORDER BY e.date DESC
    ''');
    return result;
  }

}
