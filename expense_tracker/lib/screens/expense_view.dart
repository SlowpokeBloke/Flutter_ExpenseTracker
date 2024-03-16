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

  // Builds the UI elements for the screen.
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the structure for the screen.
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense View'), // Title for the AppBar.
      ),
      // ListView.builder creates a scrollable list of widgets that are built on demand.
      body: ListView.builder(
        itemCount: _expenses.length, // The number of items the list will contain.
        itemBuilder: (context, index) {
          // Defines how each expense is represented in the list.
          final expense = _expenses[index]; // Current expense item.
          return ListTile(
            // ListTile is a single fixed-height row that typically contains some text as well as a leading or trailing icon.
            title: Text('${expense['categoryName'] ?? 'Unknown Category'}: \$${expense['amount']}'),
            trailing: Text(expense['date']), // Trailing widget in the tile, typically an icon or text.
          );
        },
      ),
      // Floating action button to refresh the expenses list.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchExpenses(); // Calls _fetchExpenses() to refresh the list when the button is pressed.
        },
        child: Icon(Icons.refresh), // Icon for the button.
      ),
    );
  }
}
