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
        FOREIGN KEY ($colCategoryId) REFERENCES $categoriesTable($colId) ON DELETE CASCADE)
    ''');
  }

// Handles database upgrades when app version changes and requires a database schema change.
void _upgradeDb(Database db, int oldVersion, int newVersion) async {
  // Compares old db and new db and proform a validation check 
  if (oldVersion < 2) {
    // If the database is from an older version that didn't have the expensesTable,
    await db.execute('''
      CREATE TABLE $expensesTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT, // Unique ID for each expense
        $colAmount INTEGER, // The amount of the expense
        $colCategoryId INTEGER, // Category ID this expense belongs to
        $colDescription TEXT, // Description of the expense
        $colDate TEXT, // Date of the expense
        FOREIGN KEY ($colCategoryId) REFERENCES $categoriesTable($colId)) // Ensures referential integrity
    ''');
  }
}

  Future<int> insertCategory(String name, int initialBudget) async {
    Database db = await this.database;
    Map<String, dynamic> category = {
      'name': name,
      'budget': initialBudget,
    };
    return await db.insert(categoriesTable, category);
  }

//delete function for category 
  Future<int> deleteCategory(int id) async {
    Database db = await database;
    return await db.delete(categoriesTable, where: '$colId = ?', whereArgs: [id]);
  }
//delete function for expense
  Future<int> deleteExpense(int id) async {
    Database db = await this.database;
    return await db.delete(expensesTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> insertExpense(Map<String, dynamic> expenseMap) async {
    Database db = await this.database;
    int result = await db.insert(expensesTable, expenseMap);
    print("Inserted expense ID: $result");
    return result;
  }


  Future<int> updateCategoryBudget(int categoryId, int budget) async {
    Database db = await database;
    return await db.update(categoriesTable, {colBudget: budget}, where: '$colId = ?', whereArgs: [categoryId]);
  }

// These lines should be removed from DatabaseHelper
  Future<List<Map<String, dynamic>>> loadExpensesDirectly() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM $expensesTable');
    print("Direct SQL expenses: $result");
    return result; // Return the fetched results for use in a widget's state
  }


  Future<List<Map<String, dynamic>>> getCategoryMapList() async {
    Database db = await database;
    return await db.query(categoriesTable);
  }

  // Method to fetch expenses joined with categories
  Future<List<Map<String, dynamic>>> getExpensesWithCategoryName() async {
    Database db = await this.database;
    List<Map<String, dynamic>> expenses = await db.rawQuery('''
      SELECT e.id, e.amount, e.date, c.name AS categoryName
      FROM $expensesTable e
      JOIN $categoriesTable c ON e.$colCategoryId = c.$colId
      ORDER BY e.$colDate DESC;
    ''');
    print("Expenses with Category Names: $expenses");
    return expenses;
  }

  Future<void> clearAllExpenses() async {
  Database db = await this.database;
  await db.delete(expensesTable); // This deletes all rows in the expensesTable
  }


  Future<List<Map<String, dynamic>>> getCategoriesWithTotalExpenses() async {
  Database db = await this.database;
  List<Map<String, dynamic>> categoriesWithExpenses = await db.rawQuery('''
    SELECT c.$colId, c.$colName, c.$colBudget, IFNULL(SUM(e.$colAmount), 0) AS totalExpenses
    FROM $categoriesTable c
    LEFT JOIN $expensesTable e ON c.$colId = e.$colCategoryId
    GROUP BY c.$colId
  ''');

  print("Categories with Total Expenses: $categoriesWithExpenses");
  return categoriesWithExpenses;
  } 

  Future<int> getTotalExpenses() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM($colAmount) as Total FROM $expensesTable'
    );
    print("Raw total expenses data: $result"); // Debugging line
    int total = result.first["Total"]?.abs() ?? 0;
    print("Calculated total expenses: $total"); // Debugging line
    return total;
  }


}
