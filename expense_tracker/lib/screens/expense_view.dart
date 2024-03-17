import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

// MyExpensesWidget is a stateful widget that displays a list of expenses.
class MyExpensesWidget extends StatefulWidget {
  @override
  _MyExpensesWidgetState createState() => _MyExpensesWidgetState();
}

// _MyExpensesWidgetState holds the state for MyExpensesWidget.
class _MyExpensesWidgetState extends State<MyExpensesWidget> {
  List<Map<String, dynamic>> _expenses = []; 

  @override
  void initState() {
    super.initState();
    _fetchExpenses(); 
  }

// Fetches expenses from the database and updates the UI.
Future<void> _fetchExpenses() async {
  var dbHelper = DatabaseHelper(); 
  var expenses = await dbHelper.getExpensesWithCategoryName(); 
  setState(() {
    _expenses = expenses; 
  });
}


  Future<void> _deleteExpense(int id) async {
    await DatabaseHelper().deleteExpense(id);
    _fetchExpenses(); 
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
          final DateTime dateTime = DateTime.parse(expense['date']);
          final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
          return ListTile(
            title: Text('${expense['categoryName'] ?? 'Unknown Category'}: \$${expense['amount']}'),
            subtitle: Text('Date: $formattedDate'), // Use the formatted date here
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
