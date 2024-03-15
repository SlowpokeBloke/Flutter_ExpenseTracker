import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class ExpenseEntry extends StatefulWidget {
  @override
  _ExpenseEntryState createState() => _ExpenseEntryState();
}

class _ExpenseEntryState extends State<ExpenseEntry> {
  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategory;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    _categories = await DatabaseHelper().getCategoryMapList();
    if (_categories.isNotEmpty) {
      _selectedCategory = _categories.first['id'].toString();
    }
    setState(() {});
  }

  void _submitExpense() async {
    if (_selectedCategory == null || _amountController.text.isEmpty) {
      // Show error or return
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a category and enter an amount')));
      return;
    }
    final int categoryId = int.parse(_selectedCategory!);
    final int expenseAmount = int.tryParse(_amountController.text) ?? 0;

    // Prepare the expense map
    Map<String, dynamic> expense = {
      'categoryId': categoryId,
      'amount': -expenseAmount, // Negative amount for expense
      'description': 'Expense entry', // Optional: Add a field to let users input a description
      'date': DateTime.now().toIso8601String(), // Current date and time
    };

    // Insert the expense into the database
    await DatabaseHelper().insertExpense(expense);

    // Optionally reset the form or show a confirmation message
    _amountController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Expense added successfully')));
    // No need to refresh categories here unless you want to reflect the updated budget or other changes
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Entry'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(category['name']),
                );
              }).toList(),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Expense Amount'),
              keyboardType: TextInputType.number,
            ),
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
