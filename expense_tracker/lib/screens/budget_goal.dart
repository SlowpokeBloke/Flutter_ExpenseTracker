import 'package:flutter/material.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class BudgetGoal extends StatefulWidget {
  const BudgetGoal({super.key});
  @override
  _BudgetGoalState createState() => _BudgetGoalState();
}

class _BudgetGoalState extends State<BudgetGoal> {
  List<Map<String, dynamic>> _categories = []; // Stores category data including budgets

  @override
  void initState() {
    super.initState();
    _loadCategoriesAndBudgets(); // Load categories and their budgets when the screen initializes
  }

  Future<void> _loadCategoriesAndBudgets() async {
    _categories = await DatabaseHelper().getCategoryMapList(); // Assumes this fetches budget info as well
    setState(() {}); // Update the state to reflect new data
  }
 // Bulds the UI elements for the screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Budget Goal'), 
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category['name']),
                  Text('Budget: ${category['budget'] ?? 'Not set'}'), // Display budget
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}