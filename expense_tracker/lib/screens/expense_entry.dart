import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

// This widget allows the user to record a new expense.
class ExpenseEntry extends StatefulWidget {
  const ExpenseEntry({super.key});
  @override
  _ExpenseEntryState createState() => _ExpenseEntryState();
}

// The corresponding state class for ExpenseEntry.
class _ExpenseEntryState extends State<ExpenseEntry> {
  List<Map<String, dynamic>> _categories = []; // This will hold a list of categories from the database.
  String? _selectedCategory; // This will hold the ID of the selected category.
  final TextEditingController _amountController = TextEditingController(); // To capture the amount entered by the user.

  // Called when this widget is inserted into the tree.
  @override
  void initState() {
    super.initState();
    _loadCategories(); // Load the list of categories at startup.
  }

  // Loads categories from the database and updates the UI.
  Future<void> _loadCategories() async {
    _categories = await DatabaseHelper().getCategoryMapList(); // Fetch the list of categories.
    if (_categories.isNotEmpty) {
      _selectedCategory = _categories.first['id'].toString(); // Automatically select the first category.
    }
    setState(() {}); // Refresh the UI with the categories loaded.
  }

  // Clled when the user submits their expense entry.
  void _submitExpense() async {
    if (_selectedCategory == null || _amountController.text.isEmpty) {
      // Show an error if no category is selected or if the amount is not entered.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a category and enter an amount')));
      return;
    }
    final int categoryId = int.parse(_selectedCategory!); // Parse the selected category ID.
    final int expenseAmount = int.tryParse(_amountController.text) ?? 0; // Parse the entered amount.

    // Create a map to hold the expense data.
    Map<String, dynamic> expense = {
      'categoryId': categoryId,
      'amount': -expenseAmount, // Store the amount as a negative value, representing an expense.
      'description': 'Expense entry', // Here we simply use a default description. You could add a field for custom descriptions.
      'date': DateTime.now().toIso8601String(), // Store the current date and time as an ISO8601 string.
    };

    // Insert the new expense into the database.
    await DatabaseHelper().insertExpense(expense);

    // Clear the form and show a confirmation message.
    _amountController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Expense added successfully')));

    // No need to call _loadCategories unless you want to display updated budget information.
  }

  // Builds the UI for the ExpenseEntry widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Entry'), // Title of the screen.
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2, // Shadow effect beneath the AppBar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for the form.
        child: Column(
          children: [
            // Dropdown for selecting a category.
            DropdownButton<String>(
              value: _selectedCategory, // Currently selected category.
              onChanged: (value) {
                // Update the selected category and refresh the UI.
                setState(() {
                  _selectedCategory = value;
                });
              },
              // Generate the list of dropdown menu items based on categories.
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(category['name']),
                );
              }).toList(),
            ),
            // Text field for entering the expense amount.
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Expense Amount'),
              keyboardType: TextInputType.number, // Show the number input keyboard.
            ),
            // Button to submit the expense.
            ElevatedButton(
              onPressed: _submitExpense,
              child: Text('Submit Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
