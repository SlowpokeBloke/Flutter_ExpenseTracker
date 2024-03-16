import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

// MyExpensesWidget is a stateful widget that displays a list of expenses.
class MyExpensesWidget extends StatefulWidget {
  @override
  _MyExpensesWidgetState createState() => _MyExpensesWidgetState();
}

// _MyExpensesWidgetState holds the state for MyExpensesWidget.
class _MyExpensesWidgetState extends State<MyExpensesWidget> {
  List<Map<String, dynamic>> _expenses = []; // This list will hold the expenses data.

  // initState() is called once when the widget is inserted into the widget tree.
  @override
  void initState() {
    super.initState();
    _fetchExpenses(); // Fetch expenses from the database on initialization.
  }

  // Fetches expenses from the database and updates the UI.
  Future<void> _fetchExpenses() async {
    var dbHelper = DatabaseHelper(); // Instance of database helper to interact with the database.
    var expenses = await dbHelper.loadExpensesDirectly(); // Fetch expenses with direct SQL query.
    setState(() {
      _expenses = expenses; // Update the state with the fetched expenses.
    });
  }

  Future<void> _deleteExpense(int id) async {
    await DatabaseHelper().deleteExpense(id);
    _fetchExpenses(); // Refresh the list after deleting the expense
  }


    // Builds the UI elements for the screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense View'),
      ),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          final expense = _expenses[index];
          return ListTile(
            title: Text('${expense['categoryName'] ?? 'Unknown Category'}: \$${expense['amount']}'),
            subtitle: Text('Date: ${expense['date']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteExpense(expense['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchExpenses,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
